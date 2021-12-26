#need to check the s3 bucket source code

resource "aws_iam_role" "lightlytics-init-role" {
  name = "${var.env_name_prefix}-lightlytics-init-role"
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
  name   = "${var.env_name_prefix}-lightlytics-init-policy"
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
                "logs:DeleteLogDelivery",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}



resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.lightlytics-init-role.name
  policy_arn = aws_iam_policy.lightlytics-init-policy.arn
}



resource "aws_lambda_function" "lightlytics-init-lambda" {
  function_name = "${var.env_name_prefix}-lightlytics-init-function"
  role          = aws_iam_role.lightlytics-init-role.arn
  architectures = var.architectures_lambda
} #default
  handler       = "app.lambda_handler"
  runtime       = "python3.8"
  memory_size   = var.memory_size
  timeout       = 900
  s3_bucket = var.s3_stack2
  environment {
    variables = {
      API_URL  = var.api_url
      ENV      = var.prod
      NODE_ENV = var.prod
    }
  }
}





resource "aws_lambda_function_event_invoke_config" "options" {
  function_name                = aws_lambda_function.lightlytics-init-lambda.function_name
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 2
}