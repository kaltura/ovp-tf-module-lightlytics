###############----------Init-------------#############
resource "aws_lambda_function" "lightlytics-init-lambda" {
  function_name = "${var.env_name_prefix}-lightlytics-init-function"
  role          = aws_iam_role.lightlytics-init-role.arn
  architectures = var.lambda_init_architectures
  handler       = "app.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.lambda_init_memory_size
  timeout       = var.lambda_init_timeout
  s3_bucket     = var.lambda_init_s3_source_code
  environment {
    variables = {
      API_URL  = var.api_url
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
  s3_bucket   = "prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"
  layer_name = "${var.env_name_prefix}-collection-dependencies"
  compatible_runtimes = ["nodejs14.x"]
}

resource "aws_lambda_function" "lightlytics-FlowLogs-lambda" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name = "${var.env_name_prefix}-lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-lambda-role.arn
  architectures = var.lambda_flow_logs_architectures
  handler       = "src/handler.s3Collector"
  runtime       = "nodejs14.x"
  memory_size   = var.lambda_flow_logs_memory_size
  timeout       = var.lambda_flow_logs_timeout
  s3_bucket = var.lambda_flow_logs_s3_source_code
  layers = [aws_lambda_layer_version.lightlytics-lambda-layer.arn]
  environment {
    variables = {
      API_TOKEN = var.api_token
      API_URL  = var.api_url
      BATCH_SIZE = var.lambda_flow_logs_batch_size
      ENV      = var.lambda_flow_logs_env
      NODE_ENV = var.lambda_flow_logs_node_env
    }
  }
}

resource "aws_lambda_function_event_invoke_config" "lightlytics-options-flow-logs" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  function_name                = aws_lambda_function.lightlytics-FlowLogs-lambda.function_name
  maximum_event_age_in_seconds = var.lambda_flow_logs_max_event_age
  maximum_retry_attempts       = var.lambda_flow_logs_max_retry
}


##############-------Flow Logs Cloud Watch---------###########

resource "aws_lambda_function" "lightlytics-FlowLogs-CloudWatch" {
  function_name = "${var.env_name_prefix}-lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-CloudWatch-role.arn
  architectures = var.lambda_flow_logs_cloud_watch_architectures #default
  handler       = "src/handler.cloudWatchCollector"
  runtime       = "nodejs14.x"
  memory_size   = var.lambda_flow_logs_cloud_watch_memory_size
  timeout       = var.lambda_flow_logs_cloud_watch_timeout
  s3_bucket = var.lambda_cloud_watch_s3_source_code
  layers = [aws_lambda_layer_version.lightlytics-lambda-layer.arn]
  environment {
    variables = {
      API_TOKEN = var.api_token
      API_URL  = var.api_url
      ENV      = var.lambda_flow_logs_cloud_watch_env
      NODE_ENV = var.lambda_flow_logs_cloud_watch_node_env
    }
  }
}


resource "aws_lambda_function_event_invoke_config" "lightlytics-options-cloud-watch" {
  function_name                = aws_lambda_function.lightlytics-FlowLogs-lambda.function_name
  maximum_event_age_in_seconds = var.lambda_flow_logs_cloud_watch_max_event_age
  maximum_retry_attempts       = var.lambda_flow_logs_cloud_watch_max_retry
}