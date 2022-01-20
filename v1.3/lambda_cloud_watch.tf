resource "aws_lambda_function" "lightlytics-CloudWatch-lambda" {
  function_name = "${var.environment}-lightlytics-function-CloudWatch"
  role          = aws_iam_role.lightlytics-CloudWatch-role.arn
#  architectures = var.lambda_flow_logs_cloud_watch_architectures   # requires aws provider 3.61
  handler       = "src/handler.cloudWatchCollector"
  runtime       = "nodejs14.x"
  memory_size   = var.lambda_flow_logs_cloud_watch_memory_size
  timeout       = var.lambda_flow_logs_cloud_watch_timeout
  s3_bucket     = var.lambda_cloud_watch_s3_source_code_bucket
  s3_key        = var.lambda_cloud_watch_s3_source_code_key
  layers        = [aws_lambda_layer_version.lightlytics-lambda-layer.arn]
  vpc_config {
    subnet_ids         = values(var.endpoint_subnet_ids)
    security_group_ids = [aws_security_group.allow_443_outbound.id]
  }
  environment {
    variables = {
      API_TOKEN = var.collection_token
      API_URL  = var.lightlytics_api_url
      ENV      = var.lambda_flow_logs_cloud_watch_env
      NODE_ENV = var.lambda_flow_logs_cloud_watch_node_env
    }
  }
}



resource "aws_lambda_function_event_invoke_config" "lightlytics-options-cloud-watch" {
  function_name                = aws_lambda_function.lightlytics-CloudWatch-lambda.function_name
  maximum_event_age_in_seconds = var.lambda_flow_logs_cloud_watch_max_event_age
  maximum_retry_attempts       = var.lambda_flow_logs_cloud_watch_max_retry
}


resource "aws_lambda_permission" "lightlytics-cloud-watch-allow-lambda" {
  for_each = local.Cloud_Watch_Rules

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lightlytics-CloudWatch-lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lightlytics-CloudWatch-rule[each.key].arn
}
