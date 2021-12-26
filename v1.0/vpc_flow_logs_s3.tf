resource "aws_s3_bucket" "lightlytics-flow-logs-bucket" {
  bucket = "${var.env_name_prefix}-lightlytics-flow-logs-bucket"
  acl    = "private"
}

resource "aws_flow_log" "lightlytics-flow-logs" {
  log_destination      = aws_s3_bucket.lightlytics-flow-logs-bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id_flow_logs
  log_format           = "${version} ${account-id} ${action} ${bytes} ${dstaddr} ${end} ${instance-id} ${interface-id} ${log-status} ${packets} ${pkt-dstaddr} ${pkt-srcaddr} ${protocol} ${region} ${srcaddr} ${srcport} ${dstport} ${start} ${vpc-id} ${subnet-id} ${tcp-flags}"
}

resource "aws_s3_bucket" "example" {
  bucket = "example"
}








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