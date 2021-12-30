###############------------Global-----------#############
variable "environment" {}
variable "account_id" {}
variable "aws_region" {}
variable "vpc_id" {}
variable "lightlytics_account" {}
variable "LightlyticsInternalAccountId" {}
variable "lightlytics_account_externalID" {
  sensitive = true
}
variable "lightlytics_auth_token" {
  sensitive = true
}
variable "collection_token" {
  sensitive = true
}
variable "domain_name" {
  default = "lightlytics.com"
}
###############----------Init-------------#############
variable "lightlytics_api_url" {
  default = "https://kaltura.lightlytics.com"
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
  default = "prod-lightlytics-artifacts-us-east-1/6087c88035a256872bdad0d7cbb3ec34"
}
#variable "lambda_init_architectures" {                                 # requires aws provider upgrade
#  default = ["x86_64"]
#}
###########------------Flow logs-----------#################
variable "collect_flow_logs_enabled" {
  default = true
  type = bool
}
variable "lambda_flow_logs_s3_source_code" {
  default = "prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"
}
variable "lambda_layer_flow_logs_s3_source_code" {
  default = "prod-lightlytics-artifacts-us-east-1/b598a9dfc1c127b51962b62d6e8d9f8f"
}
#variable "s3_flowLog" {
#  default = "kaltura-soc-flow-logs-bucket2"
#}
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
#variable "lambda_flow_logs_architectures" {                         # requires aws provider upgrade
#  default = ["x86_64"]
#}

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
#variable "lambda_flow_logs_cloud_watch_architectures" {                # requires aws provider upgrade
#  default = ["x86_64"]
#}
