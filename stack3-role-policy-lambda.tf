#need to check the s3 bucket source code

resource "aws_iam_role" "lightlytics-FlowLogs-role" {
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



resource "aws_iam_role_policy_attachment" "role-attach" {
  for_each = toset(["arn:aws:iam::aws:policy/AWSLambdaBasicExecutionRole",
  "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"])
  role       = aws_iam_role.lightlytics-FlowLogs-role.name
  policy_arn = each.value
}


#need to add layer here
resource "aws_lambda_function" "lightlytics-FlowLogs-lambda" {
  function_name = "lightlytics-function-name"
  role          = aws_iam_role.lightlytics-FlowLogs-role.arn
  architectures = "x86_64" #default
  handler       = "src/handler.s3Collector"
  runtime       = "nodejs14.x"
  memory_size   = 128 #default
  timeout       = 120
  s3_bucket = "prod-lightlytics-artifacts-us-east-1/7f0179f9b6bb21aa9456035c5d857838"
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