resource "aws_iam_role" "lightlytics-FlowLogs-lambda-role" {
#  count = var.collect_flow_logs_enabled == true ? 1 : 0
  name = "${var.environment}-lightlytics-FlowLogs-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_policy" "lightlytics-FlowLogs-lambda-policy" {
 # count = var.collect_flow_logs_enabled == true ? 1 : 0
  name   = "${var.environment}-lightlytics-FlowLogs-lambda-policy"
  path   = "/"
  policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        Action = [
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
          "ec2:UnassignPrivateIpAddresses",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetObjectVersion",
          "s3:GetLifecycleConfiguration",
          "ec2:DescribeFlowLogs"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-flow-logs" {
#  count = var.collect_flow_logs_enabled == true ? 1 : 0
  role       = aws_iam_role.lightlytics-FlowLogs-lambda-role.name
  policy_arn = aws_iam_policy.lightlytics-FlowLogs-lambda-policy.arn
}
