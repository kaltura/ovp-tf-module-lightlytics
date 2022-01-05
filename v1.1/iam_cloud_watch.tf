resource "aws_iam_role" "lightlytics-CloudWatch-role" {
  name = "${var.environment}-lightlytics-CloudWatch-role"
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


resource "aws_iam_policy" "lightlytics-CloudWatch-policy" {
  name   = "${var.environment}-lightlytics-CloudWatch-policy"
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
          "ec2:UnassignPrivateIpAddresses"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-cloud-watch" {
  role       = aws_iam_role.lightlytics-CloudWatch-role.name
  policy_arn = aws_iam_policy.lightlytics-CloudWatch-policy.arn
}
