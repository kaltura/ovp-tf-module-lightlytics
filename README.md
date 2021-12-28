#######--------OVP-TF-MODULE-Lightlytics-------#######

* Lambda
  * Init - Scans initially the entire AWs account and sends data to Lightlytics
  * CloudWatch - Creates a CloudWatch rule to monitor events and sends data to Lightlytics
  * FLowLogs - Monitors S3 bucket and sends the flow logs to Lightlytics
* IAM + Role for Lambdas
* VPC_FLOW_LOGS_S3 - takes the VPC_ID and enables flow logs with custom fields to upload to a S3 bucket that is being created.
* VAR - Must:
  * env_name_prefix
  * AccountAuthToken - Lightlytics account
* VAR - might change\need update:
  * lightlytics_account
  * lightlytics_account_externalID
  * LightlyticsInternalAccountId
  * integration_token - When creating AWS account to be connected with in Lightlytics.com, you will get the integration_token
  * RegionsToDeploy
  * lambda_init_s3_source_code
  * lambda_flow_logs_s3_source_code
  * lambda_cloud_watch_s3_source_code


FYI - $ sign is the escape sign for chars in terraform 

