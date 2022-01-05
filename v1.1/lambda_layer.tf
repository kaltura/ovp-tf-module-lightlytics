resource "aws_lambda_layer_version" "lightlytics-lambda-layer" {
  s3_bucket   = var.lambda_layer_source_code_bucket
  s3_key = var.lambda_layer_source_code_key
  layer_name = "${var.environment}-collection-dependencies"
  compatible_runtimes = ["nodejs14.x"]
}
