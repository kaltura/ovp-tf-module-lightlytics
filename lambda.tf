
resource "aws_lambda_function" "flow_logs" {
  function_name = "${var.environment}-lambda-lightlytics-flowlogs"
  role          = ""
  handler       = "src/handler.s3Collector"
  s3_bucket     = "prod-lightlytics-artifacts-us-east-1"
  s3_key        = "290fd858fd546c534ad80e4459ff57d0"
  runtime = "nodejs14.x"
  memory_size = var.memory_size
  timeout = var.timeout
  environment {
    variables = {
      BATCH_SIZE = var.batch_size
      API_TOKEN  = var.api_token
      API_URL    = var.api_url
      ENV        = var.env
      NODE_ENV   = var.node_env
    }
  }
}
