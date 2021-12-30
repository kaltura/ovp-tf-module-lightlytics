#######--------OVP-TF-MODULE-Lightlytics-------#######

After adding an account in the UI - look at the LaunchStack URL which points to the CloudFormation.yaml
get the values and use them with curl:

```
curl -X POST 'https://kaltura.lightlytics.com/graphql' \
-H 'Authorization: Bearer <AccountAuthToken>' \
-H 'Content-Type: application/json' \
-d '{"query":"mutation AccountAcknowledge($input: AccountAckInput){\r\n accountAcknowledge(account: $input)\r\n }","variables":{"input":{"lightlytics_internal_account_id":"611cc9c543c6ed7dc2c8d114","role_arn":"arn:aws:iam::"${account_id}":role/"${var.env_name_prefix}-lightlytics-role"","account_type":"AWS","account_aliases":"","aws_account_id":"325235235235","stack_region":"<AWS_REGION>","stack_id":"","init_stack_version":1}}}'
```


* Lambda
  * Init - Scans initially the entire AWs account and sends data to Lightlytics
  * CloudWatch - Creates a CloudWatch rule to monitor events and sends data to Lightlytics
  * FLowLogs - Monitors S3 bucket and sends the flow logs to Lightlytics
* IAM + Role for Lambdas
* VPC_FLOW_LOGS_S3 - takes the VPC_ID and enables flow logs with custom fields to upload to a S3 bucket that is being created.
* VAR - Must:
  * env_name_prefix
  * lightlytics_auth_token - Lightlytics account
* VAR - might change\need update:
  * lightlytics_account
  * lightlytics_account_externalID
  * LightlyticsInternalAccountId
  * collection_token - When creating AWS account to be connected with in Lightlytics.com, you will get the integration_token
  * RegionsToDeploy
  * lambda_init_s3_source_code
  * lambda_flow_logs_s3_source_code
  * lambda_cloud_watch_s3_source_code


FYI - $ sign is the escape sign for chars in terraform 

