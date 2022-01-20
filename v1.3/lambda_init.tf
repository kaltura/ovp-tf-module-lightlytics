resource "aws_lambda_function" "lightlytics-init-lambda" {
  function_name = "${var.environment}-lightlytics-init-function"
  role          = aws_iam_role.lightlytics-init-role.arn
  #  architectures = var.lambda_init_architectures   # requires aws provider 3.61
  handler       = "app.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.lambda_init_memory_size
  timeout       = var.lambda_init_timeout
  s3_bucket     = var.lambda_init_s3_source_code_bucket
  s3_key        = var.lambda_init_s3_source_code_key
  vpc_config {
    subnet_ids         = values(var.endpoint_subnet_ids)
    security_group_ids = [aws_security_group.allow_443_outbound.id]
  }
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
