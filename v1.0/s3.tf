resource "aws_s3_bucket" "flowLog-bucket" {
  count = var.ShouldCollectFLowLogs ? 1 : 0
  bucket = var.s3_flowLog
}

#############

resource "aws_s3_bucket_notification" "lambda-trigger" {
  count = var.ShouldCollectFLowLogs ? 1 : 0
  bucket = "${aws_s3_bucket.flowLog-bucket.id}"
lambda_function {
  lambda_function_arn = "${aws_lambda_function.lightlytics-FlowLogs-lambda.arn}"
  events              = ["s3:ObjectCreated:*"]
  }
}
