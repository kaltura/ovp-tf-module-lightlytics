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