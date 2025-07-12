# modules/security/cloudwatch.tf
# CloudWatch logs forwarding to Splunk

# CloudWatch Lambda Function
resource "aws_lambda_function" "cloudwatch_to_splunk" {
  filename         = "${path.module}/lambda/cloudwatch-to-splunk.zip"
  function_name    = "project5-cloudwatch-to-splunk"
  role            = aws_iam_role.lambda_role.arn
  handler         = "cloudwatch_handler.handler"
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

# Lambda permission for CloudWatch Logs
resource "aws_lambda_permission" "cloudwatch_logs" {
  statement_id  = "AllowExecutionFromCloudWatchLogs"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloudwatch_to_splunk.function_name
  principal     = "logs.amazonaws.com"
}

# Subscribe Lambda to EKS CloudWatch Logs
resource "aws_cloudwatch_log_subscription_filter" "eks_logs" {
  name            = "project5-eks-to-splunk"
  log_group_name  = "/aws/eks/${var.eks_cluster_name}/cluster"
  filter_pattern  = ""
  destination_arn = aws_lambda_function.cloudwatch_to_splunk.arn
  
  depends_on = [aws_lambda_permission.cloudwatch_logs]
}