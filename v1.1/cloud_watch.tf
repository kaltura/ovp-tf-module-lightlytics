locals {
  list             = ["1","2","3","4"]
  Cloud_Watch_Rules = {
    for_each = local.list
    Lightlytics-Rule-[each.key] = {
      description   = "Cloud Trail to Lightlytics Collection Lambda"
      is_enabled    = true
      event_pattern = file("${path.module}/templates/CloudWatch-Lightlytics-Rule-${each.key}.json")
    }
  }
}


resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch-rule" {
  for_each = local.Cloud_Watch_Rules
  name        = "${var.environment}-CW-${each.key}"
  description = each.value["description"]
  is_enabled = each.value["is_enabled"]
  event_pattern = each.value["event_pattern"]
}


resource "aws_cloudwatch_event_target" "lightlytics-lambda-cloud-watch-target" {
  for_each = local.Cloud_Watch_Rules

  rule      = aws_cloudwatch_event_rule.lightlytics-CloudWatch-rule[each.key].name
  target_id = "CloudWatchToLambda"
  arn       = aws_lambda_function.lightlytics-CloudWatch-lambda.arn
}
