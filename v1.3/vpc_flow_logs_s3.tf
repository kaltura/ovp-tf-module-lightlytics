resource "aws_s3_bucket" "lightlytics-flow-logs-bucket" {
#  count = var.collect_flow_logs_enabled == true ? 1 : 0
  bucket = "${var.environment}-lightlytics-flow-logs-bucket"
  acl    = "private"
  dynamic "lifecycle_rule" {
    for_each = var.flow_logs_bucket_lifecycle_rule
    content {
      id      = lifecycle_rule.value["id"]
      prefix  = lifecycle_rule.value["prefix"]
      enabled = lifecycle_rule.value["enabled"]
      expiration {
        days = lifecycle_rule.value["days"]
      }
    }
  }
}


resource "aws_flow_log" "lightlytics-flow-logs" {
 # count = var.collect_flow_logs_enabled == true ? 1 : 0
  log_destination      = aws_s3_bucket.lightlytics-flow-logs-bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = var.vpc_id
  log_format           = "$${version} $${account-id} $${action} $${bytes} $${dstaddr} $${end} $${instance-id} $${interface-id} $${log-status} $${packets} $${pkt-dstaddr} $${pkt-srcaddr} $${protocol} $${region} $${srcaddr} $${srcport} $${dstport} $${start} $${vpc-id} $${subnet-id} $${tcp-flags}"
}


resource "aws_s3_bucket_notification" "lightlytics-lambda-s3-trigger" {
#  count = var.collect_flow_logs_enabled == true ? 1 : 0
  for_each = aws_lambda_function.lightlytics-FlowLogs-lambda
  bucket = aws_s3_bucket.lightlytics-flow-logs-bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.lightlytics-FlowLogs-lambda[each.key].arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_lambda_permission.lightlytics-flow-logs-allow-lambda-s3]
}
