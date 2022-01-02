###############----------Init-------------#############
resource "aws_lambda_function" "lightlytics-init-lambda" {
  function_name = "${var.environment}-lightlytics-init-function"
  role          = aws_iam_role.lightlytics-init-role.arn
#  architectures = var.lambda_init_architectures   # requires aws provider upgrade
  handler       = "app.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.lambda_init_memory_size
  timeout       = var.lambda_init_timeout
  s3_bucket     = var.lambda_init_s3_source_code_bucket
  s3_key        = var.lambda_init_s3_source_code_key
  environment {
    variables = {
      API_URL  = var.lightlytics_api_url
      ENV      = var.lambda_init_env
      NODE_ENV = var.lambda_init_node_env
    }
  }
}

resource "aws_lambda_function_event_invoke_config" "lightlytics-options-init" {
  function_name                = aws_lambda_function.lightlytics-init-lambda.function_name
  maximum_event_age_in_seconds = var.lambda_init_max_event_age
  maximum_retry_attempts       = var.lambda_init_max_retry
}

###########------------Flow logs-----------#################

resource "aws_lambda_layer_version" "lightlytics-lambda-layer" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  s3_bucket   = var.lambda_layer_flow_logs_s3_source_code_bucket
  s3_key = var.lambda_layer_flow_logs_s3_source_code_key
  layer_name = "${var.environment}-collection-dependencies"
  compatible_runtimes = ["nodejs14.x"]
}

resource "aws_lambda_function" "lightlytics-FlowLogs-lambda" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name = "${var.environment}-lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-lambda-role[0].arn
#  architectures = var.lambda_flow_logs_architectures   # requires aws provider upgrade
  handler       = "src/handler.s3Collector"
  runtime       = "nodejs14.x"
  memory_size   = var.lambda_flow_logs_memory_size
  timeout       = var.lambda_flow_logs_timeout
  s3_bucket     = var.lambda_flow_logs_s3_source_code_bucket
  s3_key        = var.lambda_flow_logs_s3_source_code_key
  layers        = [aws_lambda_layer_version.lightlytics-lambda-layer[0].arn]
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
##############-------Flow Logs Cloud Watch---------###########

resource "aws_lambda_function" "lightlytics-FlowLogs-CloudWatch" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name = "${var.environment}-lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-CloudWatch-role[0].arn
#  architectures = var.lambda_flow_logs_cloud_watch_architectures   # requires aws provider upgrade
  handler       = "src/handler.cloudWatchCollector"
  runtime       = "nodejs14.x"
  memory_size   = var.lambda_flow_logs_cloud_watch_memory_size
  timeout       = var.lambda_flow_logs_cloud_watch_timeout
  s3_bucket     = var.lambda_cloud_watch_s3_source_code_bucket
  s3_key        = var.lambda_cloud_watch_s3_source_code_key
  layers        = [aws_lambda_layer_version.lightlytics-lambda-layer[0].arn]
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
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name                = aws_lambda_function.lightlytics-FlowLogs-lambda[0].function_name
  maximum_event_age_in_seconds = var.lambda_flow_logs_cloud_watch_max_event_age
  maximum_retry_attempts       = var.lambda_flow_logs_cloud_watch_max_retry
}