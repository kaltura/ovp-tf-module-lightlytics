<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.lightlytics-CloudWatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lightlytics-lambda-cloud-watch-target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_flow_log.lightlytics-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_policy.lightlytics-FlowLogs-CloudWatch-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lightlytics-FlowLogs-lambda-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lightlytics-init-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lightlytics-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.lightlytics-FlowLogs-CloudWatch-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lightlytics-FlowLogs-lambda-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lightlytics-init-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lightlytics-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-cloud-watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lightlytics-role-attach-init](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lightlytics-FlowLogs-CloudWatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.lightlytics-FlowLogs-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function.lightlytics-init-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.lightlytics-options-cloud-watch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_function_event_invoke_config.lightlytics-options-flow-logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_function_event_invoke_config.lightlytics-options-init](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_layer_version.lightlytics-lambda-layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_s3_bucket.lightlytics-flow-logs-bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_notification.lightlytics-lambda-s3-trigger](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AccountAuthToken"></a> [AccountAuthToken](#input\_AccountAuthToken) | ##############----------Init-------------############# | `string` | `"****"` | no |
| <a name="input_LightlyticsApiUrl"></a> [LightlyticsApiUrl](#input\_LightlyticsApiUrl) | variable "api\_token" { default = "IPE7Clpq7Djg\_-\_MJr3uRZM81ot1I-80SHjgk6GBhVg" } | `string` | `"https://kaltura.lightlytics.com"` | no |
| <a name="input_RegionsToDeploy"></a> [RegionsToDeploy](#input\_RegionsToDeploy) | n/a | `string` | `"us-east-1"` | no |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | variable "LightlyticsInternalAccountId" { default = "611cc9c543c6ed7dc2c8d114" } | `string` | `"https://kaltura.lightlytics.com"` | no |
| <a name="input_collect_flow_logs_enabled"></a> [collect\_flow\_logs\_enabled](#input\_collect\_flow\_logs\_enabled) | variable "lambda\_init\_architectures" {                                 # requires aws provider upgrade default = ["x86\_64"] } ##########------------Flow logs-----------################# | `bool` | `true` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | variable "lightlytics\_account" { default = 624907860825 } variable "lightlytics\_account\_externalID" { default = "ESVEV0Q9" } | `string` | `"lightlytics.com"` | no |
| <a name="input_env_name_prefix"></a> [env\_name\_prefix](#input\_env\_name\_prefix) | ##############------------Global-----------############# | `string` | `""` | no |
| <a name="input_lambda_cloud_watch_s3_source_code"></a> [lambda\_cloud\_watch\_s3\_source\_code](#input\_lambda\_cloud\_watch\_s3\_source\_code) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"` | no |
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
| <a name="input_lambda_flow_logs_memory_size"></a> [lambda\_flow\_logs\_memory\_size](#input\_lambda\_flow\_logs\_memory\_size) | variable "s3\_flowLog" { default = "kaltura-soc-flow-logs-bucket2" } | `number` | `128` | no |
| <a name="input_lambda_flow_logs_node_env"></a> [lambda\_flow\_logs\_node\_env](#input\_lambda\_flow\_logs\_node\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_flow_logs_s3_source_code"></a> [lambda\_flow\_logs\_s3\_source\_code](#input\_lambda\_flow\_logs\_s3\_source\_code) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"` | no |
| <a name="input_lambda_flow_logs_timeout"></a> [lambda\_flow\_logs\_timeout](#input\_lambda\_flow\_logs\_timeout) | n/a | `number` | `120` | no |
| <a name="input_lambda_init_env"></a> [lambda\_init\_env](#input\_lambda\_init\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_init_max_event_age"></a> [lambda\_init\_max\_event\_age](#input\_lambda\_init\_max\_event\_age) | n/a | `number` | `21600` | no |
| <a name="input_lambda_init_max_retry"></a> [lambda\_init\_max\_retry](#input\_lambda\_init\_max\_retry) | n/a | `number` | `2` | no |
| <a name="input_lambda_init_memory_size"></a> [lambda\_init\_memory\_size](#input\_lambda\_init\_memory\_size) | n/a | `number` | `128` | no |
| <a name="input_lambda_init_node_env"></a> [lambda\_init\_node\_env](#input\_lambda\_init\_node\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_lambda_init_s3_source_code"></a> [lambda\_init\_s3\_source\_code](#input\_lambda\_init\_s3\_source\_code) | n/a | `string` | `"prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"` | no |
| <a name="input_lambda_init_timeout"></a> [lambda\_init\_timeout](#input\_lambda\_init\_timeout) | n/a | `number` | `900` | no |
| <a name="input_vpc_id_flow_logs"></a> [vpc\_id\_flow\_logs](#input\_vpc\_id\_flow\_logs) | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->