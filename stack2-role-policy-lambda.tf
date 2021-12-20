#need to check the s3 bucket source code

resource "aws_iam_role" "lightlytics-init-role" {
  name = "${var.role_name_prefix}-lightlytics-init-role"
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


resource "aws_iam_policy" "lightlytics-init-policy" {
  name   = "${var.policy_name_prefix}-lightlytics-init-policy"
  path   = "/"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        Action   = [
                "ec2:DeleteFlowLogs",
                "ec2:CreateFlowLogs",
                "iam:ListAccountAliases",
                "ec2:DescribeFlowLogs",
                "ec2:DescribeVpcs",
                "ec2:CreateTags",
                "logs:CreateLogDelivery",
                "logs:DeleteLogDelivery"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}


data "aws_iam_policy" "AWSLambdaBasicExecutionRole" {
  arn = "arn:aws:iam::aws:policy/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.lightlytics-init-role.name
  policy_arn = aws_iam_policy.lightlytics-init-policy.arn
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.lightlytics-init-role.name
  policy_arn = data.aws_iam_policy.AWSLambdaBasicExecutionRole.arn
}


resource "aws_lambda_function" "lightlytics-init-lambda" {
  function_name = "lightlytics-function-name"
  role          = aws_iam_role.lightlytics-init-role.arn
  architectures = "x86_64" #default
  handler       = "app.lambda_handler"
  runtime       = "python3.8"
  memory_size   = 128 #default
  timeout       = 900
  s3_bucket = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
  environment {
    variables = {
      API_URL  = "https://kaltura.lightlytics.com"
      ENV      = "prod"
      NODE_ENV = "prod"
    }
  }
}




resource "aws_lambda_function_event_invoke_config" "options" {
  function_name                = aws_lambda_function.lightlytics-init-lambda.function_name
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 2
}