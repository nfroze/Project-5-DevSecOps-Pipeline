# modules/security/main.tf
# This file contains variables, shared resources, and outputs

# Variables
variable "splunk_hec_url" {
  description = "Splunk HEC URL"
  type        = string
}

variable "splunk_hec_token" {
  description = "Splunk HEC Token"
  type        = string
  sensitive   = true
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

# Shared Lambda execution role
resource "aws_iam_role" "lambda_role" {
  name = "project5-security-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach basic execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Create Lambda deployment packages
resource "null_resource" "lambda_packages" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command = <<EOF
# Create lambda directory
New-Item -ItemType Directory -Force -Path ${path.module}/lambda

# Create GuardDuty Lambda
@'
import json
import os
import urllib3
import uuid

def handler(event, context):
    splunk_url = os.environ['SPLUNK_HEC_URL']
    splunk_token = os.environ['SPLUNK_HEC_TOKEN']
    
    http = urllib3.PoolManager()
    
    splunk_event = {
        "event": event['detail'],
        "sourcetype": "aws:guardduty",
        "channel": str(uuid.uuid4())
    }
    
    response = http.request(
        'POST',
        splunk_url,
        body=json.dumps(splunk_event),
        headers={
            'Authorization': f'Splunk {splunk_token}',
            'Content-Type': 'application/json'
        }
    )
    
    return {
        'statusCode': response.status,
        'body': response.data.decode('utf-8')
    }
'@ | Out-File -Encoding UTF8 ${path.module}/lambda/guardduty_handler.py

# Create CloudWatch Lambda
@'
import base64
import gzip
import json
import os
import urllib3
import uuid

def handler(event, context):
    splunk_url = os.environ['SPLUNK_HEC_URL']
    splunk_token = os.environ['SPLUNK_HEC_TOKEN']
    
    http = urllib3.PoolManager()
    
    # Decode CloudWatch Logs data
    log_data = json.loads(gzip.decompress(base64.b64decode(event['awslogs']['data'])))
    
    for log_event in log_data['logEvents']:
        splunk_event = {
            "event": {
                "message": log_event['message'],
                "logGroup": log_data['logGroup'],
                "logStream": log_data['logStream'],
                "timestamp": log_event['timestamp']
            },
            "sourcetype": "aws:cloudwatch",
            "channel": str(uuid.uuid4())
        }
        
        http.request(
            'POST',
            splunk_url,
            body=json.dumps(splunk_event),
            headers={
                'Authorization': f'Splunk {splunk_token}',
                'Content-Type': 'application/json'
            }
        )
    
    return {'statusCode': 200}
'@ | Out-File -Encoding UTF8 ${path.module}/lambda/cloudwatch_handler.py

# Create zip files
Compress-Archive -Path ${path.module}/lambda/guardduty_handler.py -DestinationPath ${path.module}/lambda/guardduty-to-splunk.zip -Force
Compress-Archive -Path ${path.module}/lambda/cloudwatch_handler.py -DestinationPath ${path.module}/lambda/cloudwatch-to-splunk.zip -Force
EOF
  }
}

# Outputs
output "guardduty_detector_id" {
  value = aws_guardduty_detector.main.id
}

output "guardduty_lambda_arn" {
  value = aws_lambda_function.guardduty_to_splunk.arn
}

output "cloudwatch_lambda_arn" {
  value = aws_lambda_function.cloudwatch_to_splunk.arn
}