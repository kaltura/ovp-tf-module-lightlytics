variable "env_name_prefix" {
  default = "denis-test"
}
variable "api_url" {
  default = "https://kaltura.lightlytics.com"
}
variable "api_token" {
  default = "IPE7Clpq7Djg_-_MJr3uRZM81ot1I-80SHjgk6GBhVg"
}
variable "memory_size" {
  default = 128
}
variable "lightlytics_account" {
  default = 624907860825
}
variable "lightlytics_account_externalID" {
  default = "ESVEV0Q9"
}
variable "architectures_lambda" {
  default = "x86_64"
}
variable "prod" {
  default = "prod"
}
variable "production" {
  default = "production"
}
variable "s3_stack2" {
  default = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
}
variable "s3_stack3_lambda" {
  default = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
}
variable "s3_stack3_CloudWatch" {
  default = "prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"
}
variable "domain_name" {
  default = "lightlytics.com"
}
variable "ShouldCollectFLowLogs" {
  default = true
}
variable "RegionsToDeploy" {
  default = "us-east-1"
}


# need to create vpc flow logs with custom fields:
# ${version} ${account-id} ${action} ${bytes} ${dstaddr} ${end} ${instance-id} ${interface-id} ${log-status} ${packets} ${pkt-dstaddr} ${pkt-srcaddr} ${protocol} ${region} ${srcaddr} ${srcport} ${dstport} ${start} ${vpc-id} ${subnet-id} ${tcp-flags}
variable "s3_flowLog" {
  default = "kaltura-soc-flow-logs-bucket2"
}
