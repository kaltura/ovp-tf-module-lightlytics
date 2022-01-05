locals {
  cloud_watch_rules = {
    CW-Lightlytics-Rule-0 = {
      description = ""
      is_enabled  = true
      event_pattern = file("${path.module}/templates/cw-rule-<change_me>.json")
    }
    CW-Lightlytics-Rule-1 = {
      description = ""
      is_enabled  = true
      event_pattern = file("${path.module}/templates/cw-rule-<change_me>.json")
    }
    CW-Lightlytics-Rule-2 = {
      description = ""
      is_enabled  = true
      event_pattern = file("${path.module}/templates/cw-rule-<change_me>.json")
    }
    CW-Lightlytics-Rule-3 = {
      description = ""
      is_enabled  = true
      event_pattern = file("${path.module}/templates/cw-rule-<change_me>.json")
    }
  }
}

resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch-rule" {
  for_each = local.cloud_watch_rules
  name        = "${var.environment}-${each.key}-lightlytics-CloudWatch"
  description = each.value["description"]
  is_enabled = each.value["is_enabled"]
  event_pattern = each.value["event_pattern"]
}


resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch-rule-1" {
  name        = "${var.environment}-lightlytics-CloudWatch"
  description = "Cloud Trail to Lightlytics collection lambda"
  is_enabled = true # default
  depends_on = [aws_lambda_function.lightlytics-CloudWatch-lambda]
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2",
    "aws.ecs",
    "aws.eks",
    "aws.vpc",
    "aws.lambda",
    "aws.kafka",
    "aws.tag",
    "aws.iam",
    "aws.s3",
    "aws.dynamodb",
    "aws.elasticloadbalancing",
    "aws.autoscaling",
    "aws.health",
    "aws.monitoring",
    "aws.managedservices",
    "aws.application-autoscaling",
    "aws.applicationinsights",
    "aws.config",
    "aws.rds",
    "aws.sqs",
    "aws.cloudtrail",
    "aws.kinesis",
    "aws.cluster",
    "aws.sns",
    "aws.elasticache"
  ],
  "detail": {
    "eventName": [
      "AddTagsToStream",
      "StartDBInstance",
      "StartInstances",
      "DeregisterTaskDefinition",
      "RegisterInstancesWithLoadBalancer",
      "StopDBInstance",
      "RemoveTags",
      "DeleteManagedPrefixList",
      "TerminateInstances",
      "UnassignPrivateIpAddresses",
      "DeleteQueue",
      "ModifyInstanceAttribute",
      "DeleteBucketPolicy",
      "CreateService",
      "SetTopicAttributes",
      "ModifyDBCluster",
      "TagResource20170331v2",
      "DeleteInternetGateway",
      "SetQueueAttributes",
      "CreateDBCluster",
      "AddTags",
      "DeleteLaunchTemplateVersions",
      "PutBucketPublicAccessBlock",
      "ModifyLoadBalancerAttributes",
      "CreateReplicationGroup",
      "RegisterContainerInstance",
      "AssignPrivateIpAddresses",
      "DeleteReplicationGroup",
      "PutRolePolicy",
      "CreateDBInstance",
      "UpdateAutoScalingGroup",
      "CreateStream",
      "ModifyNetworkInterfaceAttribute",
      "AttachInternetGateway",
      "DeleteListener",
      "DeregisterTargets",
      "DeleteVpc",
      "DeleteGroup",
      "PutBucketPolicy",
      "DeleteTransitGateway",
      "CreateRole",
      "CreateVolume",
      "DeleteDBInstance",
      "AddRoleToInstanceProfile",
      "DetachNetworkInterface",
      "DeleteService",
      "AddTagsToResource",
      "CreateEgressOnlyInternetGateway",
      "TagPolicy",
      "RemoveTagsFromResource",
      "CreateFlowLogs",
      "PutBucketTagging",
      "DeleteBucket",
      "DeleteBucketPublicAccessBlock",
      "RunTask",
      "AttachLoadBalancerToSubnets",
      "ModifySecurityGroupRules",
      "DeleteEgressOnlyInternetGateway",
      "CreateLoadBalancer",
      "UpdateNodegroupConfig",
      "DeleteAutoScalingGroup",
      "AttachVolume",
      "StartDBCluster",
      "DeleteUser",
      "AcceptVpcPeeringConnection",
      "StopInstances"
    ]
  }
}
EOF
}


resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch-rule-2" {
  name        = "${var.environment}-lightlytics-CloudWatch"
  description = "Cloud Trail to Lightlytics collection lambda"
  is_enabled = true # default
  depends_on = [aws_lambda_function.lightlytics-CloudWatch-lambda]
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2",
    "aws.ecs",
    "aws.eks",
    "aws.vpc",
    "aws.lambda",
    "aws.kafka",
    "aws.tag",
    "aws.iam",
    "aws.s3",
    "aws.dynamodb",
    "aws.elasticloadbalancing",
    "aws.autoscaling",
    "aws.health",
    "aws.monitoring",
    "aws.managedservices",
    "aws.application-autoscaling",
    "aws.applicationinsights",
    "aws.config",
    "aws.rds",
    "aws.sqs",
    "aws.cloudtrail",
    "aws.kinesis",
    "aws.cluster",
    "aws.sns",
    "aws.elasticache"
  ],
  "detail": {
    "eventName": [
      "CreateNetworkInterface",
      "ReplaceRoute",
      "DeleteLoadBalancer",
      "UpdateClusterConfig",
      "ReleaseAddress",
      "DeleteRule",
      "DeleteInstanceProfile",
      "DeleteCacheCluster",
      "DeleteNetworkAclEntry",
      "StopDBCluster",
      "AssociateIamInstanceProfile",
      "AttachNetworkInterface",
      "CreateQueue",
      "DeleteVpcEndpoints",
      "ModifyVpcEndpoint",
      "SubmitTaskStateChange",
      "CreateOrUpdateTags",
      "CreateTransitGateway",
      "ApplySecurityGroupsToLoadBalancer",
      "DetachInstances",
      "AttachUserPolicy",
      "CreateLaunchTemplateVersion",
      "PutUserPolicy",
      "RunInstances",
      "DeleteStream",
      "CreateListener",
      "DeleteFunction20150331",
      "ConfigurationItemChangeNotification",
      "DeleteNetworkInterface",
      "CreateLoadBalancerListeners",
      "CreateAutoScalingGroup",
      "TagResource",
      "DeleteRoute",
      "CreateVpcPeeringConnection",
      "UntagResource20170331v2",
      "CreateVpc",
      "ModifyDBSubnetGroup",
      "PutBucketLogging",
      "DeleteLaunchConfiguration",
      "AttachInstances",
      "DeleteDBCluster",
      "CreateFunction20150331",
      "CreateInternetGateway",
      "UpdateFunctionConfiguration20150331v2",
      "ReplaceRouteTableAssociation",
      "TagQueue",
      "DeleteRolePolicy",
      "RemoveUserFromGroup",
      "DeregisterContainerInstance",
      "UntagRole",
      "AssociateDhcpOptions",
      "DeleteDBSubnetGroup",
      "ModifySubnetAttribute",
      "CreateNatGateway",
      "DeleteTopic",
      "CreateGroup",
      "DeleteUserPolicy",
      "AuthorizeSecurityGroupIngress",
      "DetachRolePolicy",
      "CreateInstanceProfile",
      "CreateBucket",
      "DeleteLoadBalancerListeners",
      "DetachGroupPolicy",
      "ModifyCacheCluster",
      "CreateDBSubnetGroup"
    ]
  }
}
EOF
}


resource "aws_cloudwatch_event_rule" "lightlytics-CloudWatch-rule-3" {
  name        = "${var.environment}-lightlytics-CloudWatch"
  description = "Cloud Trail to Lightlytics collection lambda"
  is_enabled = true # default
  depends_on = [aws_lambda_function.lightlytics-CloudWatch-lambda]
  event_pattern = <<EOF
{
  "source": [
    "aws.ec2",
    "aws.ecs",
    "aws.eks",
    "aws.vpc",
    "aws.lambda",
    "aws.kafka",
    "aws.tag",
    "aws.iam",
    "aws.s3",
    "aws.dynamodb",
    "aws.elasticloadbalancing",
    "aws.autoscaling",
    "aws.health",
    "aws.monitoring",
    "aws.managedservices",
    "aws.application-autoscaling",
    "aws.applicationinsights",
    "aws.config",
    "aws.rds",
    "aws.sqs",
    "aws.cloudtrail",
    "aws.kinesis",
    "aws.cluster",
    "aws.sns",
    "aws.elasticache"
  ],
  "detail": {
    "eventName": [
      "CreateLaunchTemplate",
      "DetachVolume",
      "DeleteVpcPeeringConnection",
      "CreateTags",
      "CreateUser",
      "DeleteRouteTable",
      "CreateSubnet",
      "CreateSecurityGroup",
      "TagRole",
      "CreateTopic",
      "UpdateBrokerCount",
      "UpdateClusterKafkaVersion",
      "UpdateBrokerStorage",
      "DisassociateVpcCidrBlock"
    ]
  }
}
EOF
}


resource "aws_cloudwatch_event_target" "lightlytics-lambda-cloud-watch-target" {
  for_each = local.cloud_watch_rules

  rule      = aws_cloudwatch_event_rule.lightlytics-CloudWatch-rule[each.key].name
  target_id = "CloudWatchToLambda"
  arn       = aws_lambda_function.lightlytics-CloudWatch-lambda.arn
}
