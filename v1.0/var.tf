###############------------Global-----------#############
variable "env_name_prefix" {
  default = "denis-test"
}
variable "lightlytics_account" {
  default = 624907860825
}
variable "lightlytics_account_externalID" {
  default = "ESVEV0Q9"
}
variable "domain_name" {
  default = "lightlytics.com"
}
###############----------Init-------------#############
variable "AccountAuthToken" {
  default = "****"
}
variable "LightlyticsInternalAccountId" {
  default = "611cc9c543c6ed7dc2c8d114"
}
variable "api_url" {
  default = "https://kaltura.lightlytics.com"
}
variable "api_token" {
  default = "IPE7Clpq7Djg_-_MJr3uRZM81ot1I-80SHjgk6GBhVg"
}
variable "LightlyticsApiUrl" {
  default = "https://kaltura.lightlytics.com"
}
variable "RegionsToDeploy" {
  default = "us-east-1"
}
variable "lambda_init_memory_size" {
  default = 128
}
variable "lambda_init_timeout" {
  default = 900
}
variable "lambda_init_env" {
  default = "prod"
}
variable "lambda_init_node_env" {
  default = "prod"
}
variable "lambda_init_max_event_age" {
  default = 21600
}
variable "lambda_init_max_retry" {
  default = 2
}
variable "lambda_init_s3_source_code" {
  default = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
}
variable "lambda_init_architectures_lambda" {
  default = "x86_64"
}
###########------------Flow logs-----------#################
variable "ShouldCollectFLowLogs" {
  default = true
  type = bool
}
variable "s3_flowLog" {
  default = "kaltura-soc-flow-logs-bucket2"
}
variable "lambda_flow_logs_memory_size" {
  default = 128
}
variable "lambda_flow_logs_timeout" {
  default = 120
}
variable "lambda_flow_logs_env" {
  default = "prod"
}
variable "lambda_flow_logs_node_env" {
  default = "prod"
}
variable "lambda_flow_logs_batch_size" {
  default = 1000
}
variable "lambda_flow_logs_max_event_age" {
  default = 21600
}
variable "lambda_flow_logs_max_retry" {
  default = 2
}
variable "lambda_flow_logs_s3_source_code" {
  default = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
}
variable "lambda_flow_logs_architectures_lambda" {
  default = "x86_64"
}
##############-------Flow Logs Cloud Watch---------###########
variable "lambda_flow_logs_cloud_watch_memory_size" {
  default = 128
}
variable "lambda_flow_logs_cloud_watch_timeout" {
  default = 120
}
variable "lambda_flow_logs_cloud_watch_env" {
  default = "production"
}
variable "lambda_flow_logs_cloud_watch_node_env" {
  default = "production"
}
variable "lambda_flow_logs_cloud_watch_max_event_age" {
  default = 21600
}
variable "lambda_flow_logs_cloud_watch_max_retry" {
  default = 2
}
variable "lambda_cloud_watch_s3_source_code" {
  default = "prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"
}
variable "lambda_flow_logs_cloud_watch_architectures_lambda" {
  default = "x86_64"
}


# need to create vpc flow logs with custom fields:
# ${version} ${account-id} ${action} ${bytes} ${dstaddr} ${end} ${instance-id} ${interface-id} ${log-status} ${packets} ${pkt-dstaddr} ${pkt-srcaddr} ${protocol} ${region} ${srcaddr} ${srcport} ${dstport} ${start} ${vpc-id} ${subnet-id} ${tcp-flags}





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
