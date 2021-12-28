###############------------Global-----------#############
variable "env_name_prefix" {
  default = ""
}
variable "lightlytics_account" {
  default = ""
}
variable "lightlytics_account_externalID" {
  default = ""
}
variable "domain_name" {
  default = "lightlytics.com"
}
###############----------Init-------------#############
variable "AccountAuthToken" {
  default = "****"
}
variable "LightlyticsInternalAccountId" {
  default = ""
}
variable "api_url" {
  default = "https://kaltura.lightlytics.com"
}
variable "integration_token" {
  default = ""
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
#variable "lambda_init_architectures" {                                 # requires aws provider upgrade
#  default = ["x86_64"]
#}
###########------------Flow logs-----------#################
variable "collect_flow_logs_enabled" {
  default = true
  type = bool
}
variable "vpc_id_flow_logs" {
  default = ""
}
variable "lambda_flow_logs_s3_source_code" {
  default = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
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


# need to create vpc flow logs with custom fields:
# ${version} ${account-id} ${action} ${bytes} ${dstaddr} ${end} ${instance-id} ${interface-id} ${log-status} ${packets} ${pkt-dstaddr} ${pkt-srcaddr} ${protocol} ${region} ${srcaddr} ${srcport} ${dstport} ${start} ${vpc-id} ${subnet-id} ${tcp-flags}

