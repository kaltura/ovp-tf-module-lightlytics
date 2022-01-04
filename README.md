#######--------OVP-TF-MODULE-Lightlytics-------#######

Adding account:
* MUST BE SIGNED IN BROWSER TO THE ACCOUNT YOU ARE ABOUT TO ADD
* Under the relevant Workspace --> Settings mechanical wheel --> Integrations --> Click the plus sign "+" to add and account --> 
  Input the Account ID + display name and click "Add Account" --> click the "Launch Stack" which will open it in the AWS Account 
  and navigate to the URL which points to the CloudFormation.yaml --> click "Continue" --> click "Close and Cancel"
* North Virginia has to be added as a default region in Lightlytics
* Get the values and update them in the Secret Manager - "lightlytics-secrets":
  * LightlyticsInternalAccountId
  * AccountAuthToken
  * LightlyticsCollectionToken
  * ExternalId

The following vars are taken from the main OVP:
* variable "environment" {}
* variable "account_id" {}
* variable "aws_region" {}
* variable "vpc_id" {}


* VAR - might change\need update:
  * lightlytics_account
  * collect_flow_logs_enabled
  * Lambda source code and key:
    * s3_bucket = "prod-lightlytics-artifacts-us-east-1"
    * s3_key - depending on the lambda


* Lambda
  * Init - Scans initially the entire AWS account and sends data to Lightlytics
  * CloudWatch - Creates a CloudWatch rule to monitor events and sends data to Lightlytics In real time
  * FLowLogs - Monitors S3 bucket and sends the flow logs to Lightlytics


* Curl command that enables the Account
```
curl -X POST 'https://kaltura.lightlytics.com/graphql' \
-H 'Authorization: Bearer <AccountAuthToken>' \
-H 'Content-Type: application/json' \
-d '{"query":"mutation AccountAcknowledge($input: AccountAckInput){\r\n accountAcknowledge(account: $input)\r\n }","variables":{"input":{"lightlytics_internal_account_id":"611cc9c543c6ed7dc2c8d114","role_arn":"arn:aws:iam::"${account_id}":role/"${var.environment}-lightlytics-role"","account_type":"AWS","account_aliases":"","aws_account_id":"325235235235","stack_region":"<AWS_REGION>","stack_id":"","init_stack_version":1}}}'
```


FYI - $ sign is the escape sign for chars in terraform




<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.70.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_LightlyticsInternalAccountId"></a> [LightlyticsInternalAccountId](#input\_LightlyticsInternalAccountId) | n/a | `any` | n/a | yes |
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_collect_flow_logs_enabled"></a> [collect\_flow\_logs\_enabled](#input\_collect\_flow\_logs\_enabled) | variable "lambda\_init\_architectures" {                                 # requires aws provider upgrade  to 3.61 default = ["x86\_64"] } ##########------------Flow logs-----------################# | `bool` | `true` | no |
| <a name="input_collection_token"></a> [collection\_token](#input\_collection\_token) | n/a | `any` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `"lightlytics.com"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ##############------------Global-----------############# | `any` | n/a | yes |
| <a name="input_lambda_cloud_watch_s3_source_code_bucket"></a> [lambda\_cloud\_watch\_s3\_source\_code\_bucket](#input\_lambda\_cloud\_watch\_s3\_source\_code\_bucket) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1"` | no |
| <a name="input_lambda_cloud_watch_s3_source_code_key"></a> [lambda\_cloud\_watch\_s3\_source\_code\_key](#input\_lambda\_cloud\_watch\_s3\_source\_code\_key) | n/a | `string` | `"290fd858fd546c534ad80e4459ff57d0"` | no |
| <a name="input_lambda_flow_logs_batch_size"></a> [lambda\_flow\_logs\_batch\_size](#input\_lambda\_flow\_logs\_batch\_size) | n/a | `number` | `1000` | no |
| <a name="input_lambda_flow_logs_cloud_watch_env"></a> [lambda\_flow\_logs\_cloud\_watch\_env](#input\_lambda\_flow\_logs\_cloud\_watch\_env) | n/a | `string` | `"production"` | no |
| <a name="input_lambda_flow_logs_cloud_watch_max_event_age"></a> [lambda\_flow\_logs\_cloud\_watch\_max\_event\_age](#input\_lambda\_flow\_logs\_cloud\_watch\_max\_event\_age) | n/a | `number` | `21600` | no |
| <a name="input_lambda_flow_logs_cloud_watch_max_retry"></a> [lambda\_flow\_logs\_cloud\_watch\_max\_retry](#input\_lambda\_flow\_logs\_cloud\_watch\_max\_retry) | n/a | `number` | `2` | no |
| <a name="input_lambda_flow_logs_cloud_watch_memory_size"></a> [lambda\_flow\_logs\_cloud\_watch\_memory\_size](#input\_lambda\_flow\_logs\_cloud\_watch\_memory\_size) | #############-------Flow Logs Cloud Watch---------########### | `number` | `128` | no |
| <a name="input_lambda_flow_logs_cloud_watch_node_env"></a> [lambda\_flow\_logs\_cloud\_watch\_node\_env](#input\_lambda\_flow\_logs\_cloud\_watch\_node\_env) | n/a | `string` | `"production"` | no |
| <a name="input_lambda_flow_logs_cloud_watch_timeout"></a> [lambda\_flow\_logs\_cloud\_watch\_timeout](#input\_lambda\_flow\_logs\_cloud\_watch\_timeout) | n/a | `number` | `120` | no |
| <a name="input_lambda_flow_logs_env"></a> [lambda\_flow\_logs\_env](#input\_lambda\_flow\_logs\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_flow_logs_max_event_age"></a> [lambda\_flow\_logs\_max\_event\_age](#input\_lambda\_flow\_logs\_max\_event\_age) | n/a | `number` | `21600` | no |
| <a name="input_lambda_flow_logs_max_retry"></a> [lambda\_flow\_logs\_max\_retry](#input\_lambda\_flow\_logs\_max\_retry) | n/a | `number` | `2` | no |
| <a name="input_lambda_flow_logs_memory_size"></a> [lambda\_flow\_logs\_memory\_size](#input\_lambda\_flow\_logs\_memory\_size) | n/a | `number` | `128` | no |
| <a name="input_lambda_flow_logs_node_env"></a> [lambda\_flow\_logs\_node\_env](#input\_lambda\_flow\_logs\_node\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_flow_logs_s3_source_code_bucket"></a> [lambda\_flow\_logs\_s3\_source\_code\_bucket](#input\_lambda\_flow\_logs\_s3\_source\_code\_bucket) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1"` | no |
| <a name="input_lambda_flow_logs_s3_source_code_key"></a> [lambda\_flow\_logs\_s3\_source\_code\_key](#input\_lambda\_flow\_logs\_s3\_source\_code\_key) | n/a | `string` | `"290fd858fd546c534ad80e4459ff57d0"` | no |
| <a name="input_lambda_flow_logs_timeout"></a> [lambda\_flow\_logs\_timeout](#input\_lambda\_flow\_logs\_timeout) | n/a | `number` | `120` | no |
| <a name="input_lambda_init_env"></a> [lambda\_init\_env](#input\_lambda\_init\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_init_max_event_age"></a> [lambda\_init\_max\_event\_age](#input\_lambda\_init\_max\_event\_age) | n/a | `number` | `21600` | no |
| <a name="input_lambda_init_max_retry"></a> [lambda\_init\_max\_retry](#input\_lambda\_init\_max\_retry) | n/a | `number` | `2` | no |
| <a name="input_lambda_init_memory_size"></a> [lambda\_init\_memory\_size](#input\_lambda\_init\_memory\_size) | n/a | `number` | `128` | no |
| <a name="input_lambda_init_node_env"></a> [lambda\_init\_node\_env](#input\_lambda\_init\_node\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_init_s3_source_code_bucket"></a> [lambda\_init\_s3\_source\_code\_bucket](#input\_lambda\_init\_s3\_source\_code\_bucket) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1"` | no |
| <a name="input_lambda_init_s3_source_code_key"></a> [lambda\_init\_s3\_source\_code\_key](#input\_lambda\_init\_s3\_source\_code\_key) | n/a | `string` | `"6087c88035a256872bdad0d7cbb3ec34"` | no |
| <a name="input_lambda_init_timeout"></a> [lambda\_init\_timeout](#input\_lambda\_init\_timeout) | n/a | `number` | `900` | no |
| <a name="input_lambda_layer_flow_logs_s3_source_code_bucket"></a> [lambda\_layer\_flow\_logs\_s3\_source\_code\_bucket](#input\_lambda\_layer\_flow\_logs\_s3\_source\_code\_bucket) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1"` | no |
| <a name="input_lambda_layer_flow_logs_s3_source_code_key"></a> [lambda\_layer\_flow\_logs\_s3\_source\_code\_key](#input\_lambda\_layer\_flow\_logs\_s3\_source\_code\_key) | n/a | `string` | `"b598a9dfc1c127b51962b62d6e8d9f8f"` | no |
| <a name="input_lightlytics_account"></a> [lightlytics\_account](#input\_lightlytics\_account) | n/a | `any` | n/a | yes |
| <a name="input_lightlytics_account_externalID"></a> [lightlytics\_account\_externalID](#input\_lightlytics\_account\_externalID) | n/a | `any` | n/a | yes |
| <a name="input_lightlytics_api_url"></a> [lightlytics\_api\_url](#input\_lightlytics\_api\_url) | ##############----------Init-------------############# | `string` | `"https://kaltura.lightlytics.com"` | no |
| <a name="input_lightlytics_auth_token"></a> [lightlytics\_auth\_token](#input\_lightlytics\_auth\_token) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->