resource "aws_lambda_function" "lightlytics-FlowLogs-lambda" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name = "${var.environment}-lightlytics-function-FlowLogs-lambda"
  role          = aws_iam_role.lightlytics-FlowLogs-lambda-role[0].arn
#  architectures = var.lambda_flow_logs_architectures   # requires aws provider 3.61
  handler       = "src/handler.s3Collector"
  runtime       = "nodejs14.x"
  memory_size   = var.lambda_flow_logs_memory_size
  timeout       = var.lambda_flow_logs_timeout
  s3_bucket     = var.lambda_flow_logs_s3_source_code_bucket
  s3_key        = var.lambda_flow_logs_s3_source_code_key
  layers        = [aws_lambda_layer_version.lightlytics-lambda-layer.arn]
  vpc_config {
    subnet_ids         = [var.endpoint_subnet_ids]
    security_group_ids = [aws_security_group.allow_443_outbound.id]
  }
  environment {
    variables = {
      API_TOKEN = var.collection_token
      API_URL  = var.lightlytics_api_url
      BATCH_SIZE = var.lambda_flow_logs_batch_size
      ENV      = var.lambda_flow_logs_env
      NODE_ENV = var.lambda_flow_logs_node_env
    }
  }
}


resource "aws_lambda_function_event_invoke_config" "lightlytics-options-flow-logs" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name                = aws_lambda_function.lightlytics-FlowLogs-lambda[0].function_name
  maximum_event_age_in_seconds = var.lambda_flow_logs_max_event_age
  maximum_retry_attempts       = var.lambda_flow_logs_max_retry
}


resource "aws_lambda_permission" "lightlytics-flow-logs-allow-lambda-s3" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lightlytics-FlowLogs-lambda[0].arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.lightlytics-flow-logs-bucket[0].arn
}
