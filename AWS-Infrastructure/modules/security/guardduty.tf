# modules/security/guardduty.tf
# GuardDuty threat detection and Splunk forwarding

# Enable GuardDuty
resource "aws_guardduty_detector" "main" {
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
  }

  tags = {
    Name = "project5-guardduty"
  }
}

# EventBridge Rule for GuardDuty findings
resource "aws_cloudwatch_event_rule" "guardduty" {
  name        = "project5-guardduty-findings"
  description = "Capture all GuardDuty findings"

  event_pattern = jsonencode({
    source      = ["aws.guardduty"]
    detail-type = ["GuardDuty Finding"]
  })
}

# GuardDuty Lambda Function
resource "aws_lambda_function" "guardduty_to_splunk" {
  filename         = "${path.module}/lambda/guardduty-to-splunk.zip"
  function_name    = "project5-guardduty-to-splunk"
  role            = aws_iam_role.lambda_role.arn
  handler         = "guardduty_handler.handler"
  runtime         = "python3.11"
  timeout         = 60

  environment {
    variables = {
      SPLUNK_HEC_URL   = var.splunk_hec_url
      SPLUNK_HEC_TOKEN = var.splunk_hec_token
    }
  }

  depends_on = [null_resource.lambda_packages]
}

# EventBridge Target for GuardDuty
resource "aws_cloudwatch_event_target" "guardduty_lambda" {
  rule      = aws_cloudwatch_event_rule.guardduty.name
  target_id = "GuardDutyToSplunk"
  arn       = aws_lambda_function.guardduty_to_splunk.arn
}

# Lambda permission for EventBridge
resource "aws_lambda_permission" "guardduty_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.guardduty_to_splunk.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.guardduty.arn
}