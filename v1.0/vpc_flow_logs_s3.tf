resource "aws_s3_bucket" "lightlytics-flow-logs-bucket" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  bucket = "${var.env_name_prefix}-lightlytics-flow-logs-bucket"
  acl    = "private"
}


resource "aws_flow_log" "lightlytics-flow-logs" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  log_destination      = aws_s3_bucket.lightlytics-flow-logs-bucket[0].arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id_flow_logs
#  log_format           = "${version} ${account-id} ${action} ${bytes} ${dstaddr} ${end} ${instance-id} ${interface-id} ${log-status} ${packets} ${pkt-dstaddr} ${pkt-srcaddr} ${protocol} ${region} ${srcaddr} ${srcport} ${dstport} ${start} ${vpc-id} ${subnet-id} ${tcp-flags}"
   log_format           = "$${version} $${account-id} $${action}"
}



resource "aws_s3_bucket_notification" "lightlytics-lambda-s3-trigger" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  bucket = aws_s3_bucket.lightlytics-flow-logs-bucket[0].id
lambda_function {
  lambda_function_arn = aws_lambda_function.lightlytics-FlowLogs-lambda[0].arn
  events              = ["s3:ObjectCreated:*"]
  }
}