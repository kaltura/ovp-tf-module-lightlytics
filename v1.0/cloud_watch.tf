resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  name        = "${var.environment}-lightlytics-CloudWatch"
  description = "Cloud Trail to Lightlytics collection lambda"
  is_enabled = true #default
  depends_on = [aws_lambda_function.lightlytics-CloudWatch-lambda]
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

resource "aws_cloudwatch_event_target" "lightlytics-lambda-cloud-watch-target" {
  count = var.collect_flow_logs_enabled == true ? 1 : 0
  rule      = aws_cloudwatch_event_rule.lightlytics-CloudWatch[0].name
  target_id = "CloudWatchToLambda"
  arn       = aws_lambda_function.lightlytics-CloudWatch-lambda[0].arn
  depends_on = [aws_lambda_function.lightlytics-CloudWatch-lambda]
}
