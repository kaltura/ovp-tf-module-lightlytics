Kaltura - Lightlytics terraform module
===========

A terraform module connecting AWS account to Lightlytics


Module Input Variables
----------------------

- `environment`                                  = variable environment
- `account_id`                                   = variable name
- `aws_region`                                   = variable aws_region
- `vpc_id`                                       = variable vpc_id
- `lambda_init_s3_source_code_bucket`            = "<Lightlytics_S3_Bucket>-${var.aws_region}"
- `lambda_init_s3_source_code_key`               = S3_Key
- `lambda_layer_source_code_bucket`              = "<Lightlytics_S3_Bucket>-${var.aws_region}"
- `lambda_layer_source_code_key`                 = S3_Key
- `lambda_flow_logs_s3_source_code_bucket`       = "<Lightlytics_S3_Bucket>-${var.aws_region}"
- `lambda_flow_logs_s3_source_code_key`          = S3_Key
- `lambda_cloud_watch_s3_source_code_bucket`     = "<Lightlytics_S3_Bucket>-${var.aws_region}"
- `lambda_cloud_watch_s3_source_code_key`        = S3_Key
- `lightlytics_account`                          = variable lightlytics_account
- `LightlyticsInternalAccountId`                 = variable LightlyticsInternalAccountId
- `lightlytics_account_externalID`               = variable lightlytics_account_externalID
- `lightlytics_auth_token`                       = variable lightlytics_auth_token
- `collection_token`                             = variable collection_token


Usage
-----

```hcl
module "lightlytics" {
  source = "github.com/kaltura/ovp-tf-module-lightlytics/<VERSION>"
  environment                         =
  account_id                          =
  aws_region                          =   
  vpc_id                              = 
  lightlytics_account                 =
  LightlyticsInternalAccountId        =
  lightlytics_account_externalID      =   
  lightlytics_auth_token              = 
  collection_token                    = 
  tags {
    "Environment" = "${var.environment}"
  }
}
```


Authors
=======

dennis.litvak@kaltura.com


Adding AWS account
-----

- MUST BE SIGNED IN BROWSER TO THE ACCOUNT YOU ARE ABOUT TO ADD
- Under the relevant Workspace --> Settings "mechanical wheel" --> "Integrations" --> Click the plus sign "+" to add and account --> 
  Input the Account ID + display name and click "Add Account" --> click the "Launch Stack" which will open it in the AWS Account 
  and navigate to the URL which points to the CloudFormation.yaml --> click "Continue" --> click "Close and Cancel"
- North Virginia has to be added as a default region in Lightlytics
- Get the values and update them in the Secret Manager - "lightlytics-secrets":
  - LightlyticsInternalAccountId
  - AccountAuthToken
  - LightlyticsCollectionToken
  - ExternalId

- The following vars are taken from the main tf.state:
  - variable "environment" {}
  - variable "account_id" {}
  - variable "aws_region" {}
  - variable "vpc_id" {}


- VAR - might change\need update:
  - lightlytics_account
  - Lambda source code and key:
    - s3_bucket = "prod-lightlytics-artifacts-us-east-1"
    - s3_key - depending on the lambda


- Lambda
  - Init - Scans initially the entire AWS account and sends data to Lightlytics
  - CloudWatch - Creates a CloudWatch rule to monitor events and sends data to Lightlytics In real time
  - FLowLogs - Monitors S3 bucket and sends the flow logs to Lightlytics
    - collect_flow_logs_enabled - `true\false` - select your requirements


- Curl command that enables the Account
```bash
    curl -X POST '${var.lightlytics_api_url}/graphql' \
      -H 'Content-Type: application/json' \
      -H 'Authorization: Bearer ${var.lightlytics_auth_token}' \
      -d '{"query":"mutation AccountAcknowledge($input: AccountAckInput){\r\n accountAcknowledge(account: $input)\r\n }","variables": {"input": {"lightlytics_internal_account_id":"${var.LightlyticsInternalAccountId}","role_arn":"arn:aws:iam::${var.account_id}:role/${var.environment}-lightlytics-role","account_type":"AWS","account_aliases":"","aws_account_id":"${var.account_id}","stack_region":"${var.aws_region}","stack_id":"","init_stack_version":1}}}'
```


## Feature notes

v1.0
-----

- Lambda
- IAM Policy & Roles
- Var
- VPC Flow Logs & S3 Bucket
- Cloud Watch Rule
- curl


v1.1
-----

- New Cloud Watch Rules
- Flow Logs S3 Bucket LifeCycle Rule


v1.2
-----

- Extracted S3 Lambda source + Key
- Lambda Batch updates from 1000 to 4000



# How you can help (guidelines for contributors) 
Thank you for helping Kaltura grow! If you'd like to contribute please follow these steps:
* Use the repository issues tracker to report bugs or feature requests
* Read [Contributing Code to the Kaltura Platform](https://github.com/kaltura/platform-install-packages/blob/master/doc/Contributing-to-the-Kaltura-Platform.md)
* Sign the [Kaltura Contributor License Agreement](https://agentcontribs.kaltura.org/)


# Where to get help
* Join the [Kaltura Community Forums](https://forum.kaltura.org/) to ask questions or start discussions
* Read the [Code of conduct](https://forum.kaltura.org/faq) and be patient and respectful


# Get in touch
You can learn more about Kaltura and start a free trial at: http://corp.kaltura.com    
Contact us via Twitter [@Kaltura](https://twitter.com/Kaltura) or email: community@kaltura.com  
We'd love to hear from you!


# License and Copyright Information
All code in this project is released under the [AGPLv3 license](http://www.gnu.org/licenses/agpl-3.0.html) unless a different license for a particular library is specified in the applicable library path.   

Copyright © Kaltura Inc. All rights reserved.   
Authors and contributors: See [GitHub contributors list](https://github.com/kaltura/YOURREPONAME/graphs/contributors).  


### Open Source Libraries


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |


## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.lightlytics-CloudWatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lightlytics-lambda-cloud-watch-target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_flow_log.lightlytics-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_policy.lightlytics-CloudWatch-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lightlytics-FlowLogs-lambda-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lightlytics-init-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lightlytics-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lightlytics-CloudWatch-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lightlytics-FlowLogs-lambda-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lightlytics-init-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lightlytics-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-cloud-watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-init](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lightlytics-CloudWatch-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.lightlytics-FlowLogs-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.lightlytics-init-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.lightlytics-options-cloud-watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_function_event_invoke_config.lightlytics-options-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_function_event_invoke_config.lightlytics-options-init](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_layer_version.lightlytics-lambda-layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_lambda_permission.lightlytics-cloud-watch-allow-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.lightlytics-flow-logs-allow-lambda-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.lightlytics-flow-logs-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.lightlytics-lambda-s3-trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [null_resource.lightlytics-enable-account](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.wait_15_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

