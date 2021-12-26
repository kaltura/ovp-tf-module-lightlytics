#need to check the s3 bucket source code

resource "aws_iam_role" "lightlytics-FlowLogs-lambda-role" {
  name = "${var.role_name_prefix}-lightlytics-FlowLogs-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


#################

resource "aws_iam_policy" "lightlytics-FlowLogs-lambda-policy" {
  name   = "${var.policy_name_prefix}-lightlytics-FlowLogs-lambda-policy"
  path   = "/"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        Action   = [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:AssignPrivateIpAddresses",
                "ec2:UnassignPrivateIpAddresses"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}

###########

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.lightlytics-FlowLogs-lambda-role.name
  policy_arn = aws_iam_policy.lightlytics-FlowLogs-lambda-policy.arn
}


############


resource "aws_lambda_layer_version" "lambda_layer" {
  s3_bucket   = "prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"
  layer_name = "collection-dependencies"

  compatible_runtimes = ["nodejs14.x"]
}



##############

#need to add layer here
resource "aws_lambda_function" "lightlytics-FlowLogs-lambda" {
  function_name = "lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-lambda-role.arn
  architectures = "x86_64" #default
  handler       = "src/handler.s3Collector"
  runtime       = "nodejs14.x"
  memory_size   = 128 #default
  timeout       = 120
  s3_bucket = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
  environment {
    variables = {
      API_TOKEN = "IPE7Clpq7Djg_-_MJr3uRZM81ot1I-80SHjgk6GBhVg"
      API_URL  = "https://kaltura.lightlytics.com"
      BATCH_SIZE = "1000"
      ENV      = "production"
      NODE_ENV = "production"
    }
  }
}


resource "aws_lambda_function_event_invoke_config" "options" {
  function_name                = aws_lambda_function.lightlytics-FlowLogs-lambda.function_name
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 2
}



################
# HOW D I TYPE "Matched events"??
resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch" {
  name        = "lightlytics-CloudWatch"
  description = "Cloud Trail to Lightlytics collection lambda"
  is_enabled = true #default
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2", "aws.ecs", "aws.eks", "aws.vpc",
    "aws.lambda", "aws.kafka", "aws.tag", "aws.iam",
    "aws.s3", "aws.dynamodb", "aws.elasticloadbalancing",
    "aws.autoscaling", "aws.health", "aws.monitoring",
    "aws.managedservices", "aws.application-autoscaling",
    "aws.applicationinsights", "aws.config", "aws.rds",
    "aws.sqs", "aws.cloudtrail", "aws.kinesis", "aws.cluster"
    ]
}
EOF
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.lightlytics-CloudWatch.name
  target_id = "CloudWatchToLambda"
  arn       = aws_lambda_function.lightlytics-FlowLogs-lambda.arn
}

##############

resource "aws_iam_role" "lightlytics-FlowLogs-CloudWatch-role" {
  name = "${var.role_name_prefix}-lightlytics-FlowLogs-CloudWatch-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

####################

resource "aws_iam_policy" "lightlytics-FlowLogs-CloudWatch-policy" {
  name   = "${var.policy_name_prefix}-lightlytics-FlowLogs-CloudWatch-policy"
  path   = "/"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        Action   = [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "ec2:AssignPrivateIpAddresses",
                "ec2:UnassignPrivateIpAddresses"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}


#############

resource "aws_lambda_function" "lightlytics-FlowLogs-CloudWatch" {
  function_name = "lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-CloudWatch-role.arn
  architectures = "x86_64" #default
  handler       = "src/handler.cloudWatchCollector"
  runtime       = "nodejs14.x"
  memory_size   = 128 #default
  timeout       = 120
  s3_bucket = "prod-lightlytics-artifacts-us-east-1/290fd858fd546c534ad80e4459ff57d0"
  layers = [aws_lambda_layer_version.lambda_layer.arn]
  environment {
    variables = {
      API_TOKEN = "IPE7Clpq7Djg_-_MJr3uRZM81ot1I-80SHjgk6GBhVg"
      API_URL  = "https://kaltura.lightlytics.com"
      ENV      = "production"
      NODE_ENV = "production"
    }
  }
}


resource "aws_lambda_function_event_invoke_config" "options" {
  function_name                = aws_lambda_function.lightlytics-FlowLogs-lambda.function_name
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 2
}