resource "aws_iam_role" "lightlytics-role" {
  name = "${var.environment}-lightlytics-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.lightlytics_account}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.lightlytics_account_externalID}"
        }
      }
    }
  ]
}
EOF
}


resource "aws_iam_policy" "lightlytics-policy" {
  name   = "${var.environment}-lightlytics-policy"
  path   = "/"
  policy = jsonencode({

    "Version" : "2012-10-17"
    "Statement" : [
      {
        Action = [
          "apigateway:GetResources",
          "apigateway:GetRestApis",
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeLaunchConfigurations",
          "cloudfront:ListDistributions",
          "cloudfront:ListTagsForResource",
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:DescribeTable",
          "dynamodb:ListBackups",
          "dynamodb:ListTables",
          "dynamodb:ListTagsOfResource",
          "ec2:DescribeAddresses",
          "ec2:DescribeCustomerGateways",
          "ec2:DescribeEgressOnlyInternetGateways",
          "ec2:DescribeFlowLogs",
          "ec2:DescribeInstances",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:DescribeManagedPrefixLists",
          "ec2:DescribeNatGateways",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeTags",
          "ec2:DescribeTransitGatewayAttachments",
          "ec2:DescribeTransitGatewayRouteTables",
          "ec2:DescribeTransitGateways",
          "ec2:DescribeVolumes",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeVpcEndpoints",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpnConnections",
          "ec2:DescribeVpnGateways",
          "ec2:GetManagedPrefixListEntries",
          "ec2:GetTransitGatewayRouteTableAssociations",
          "ec2:SearchTransitGatewayRoutes",
          "ecs:DescribeClusters",
          "ecs:DescribeContainerInstances",
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:DescribeTasks",
          "ecs:ListClusters",
          "ecs:ListContainerInstances",
          "ecs:ListServices",
          "ecs:ListTagsForResource",
          "ecs:ListTaskDefinitions",
          "ecs:ListTasks",
          "eks:DescribeCluster",
          "eks:DescribeNodegroup",
          "eks:ListClusters",
          "eks:ListNodegroups",
          "elasticache:DescribeCacheClusters",
          "elasticache:DescribeCacheSubnetGroups",
          "elasticache:ListTagsForResource",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:DescribeTags",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticmapreduce:DescribeCluster",
          "elasticmapreduce:ListClusters",
          "elasticmapreduce:ListInstanceFleets",
          "elasticmapreduce:ListInstanceGroups",
          "elasticmapreduce:ListInstances",
          "es:DescribeDomains",
          "es:ListDomainNames",
          "es:ListTags",
          "iam:GetAccountAuthorizationDetails",
          "iam:GetInstanceProfile",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:GetUserPolicy",
          "iam:ListAttachedGroupPolicies",
          "iam:ListAttachedRolePolicies",
          "iam:ListAttachedUserPolicies",
          "iam:ListGroupPolicies",
          "iam:ListGroups",
          "iam:ListGroupsForUser",
          "iam:ListInstanceProfiles",
          "iam:ListMfaDevices",
          "iam:ListPolicies",
          "iam:ListRolePolicies",
          "iam:ListRoleTags",
          "iam:ListRoles",
          "iam:ListUserPolicies",
          "iam:ListUserTags",
          "iam:ListUsers",
          "kafka:ListClusters",
          "kinesis:DescribeStream",
          "kinesis:ListStreams",
          "kinesis:ListTagsForStream",
          "kms:DescribeKey",
          "kms:GetKeyPolicy",
          "kms:ListAliases",
          "kms:ListKeys",
          "kms:ListResourceTags",
          "lambda:GetFunction",
          "lambda:GetPolicy",
          "lambda:GetProvisionedConcurrencyConfig",
          "lambda:ListEventSourceMappings",
          "lambda:ListFunctions",
          "lambda:ListTags",
          "rds:DescribeDbInstances",
          "rds:DescribeDbSubnetGroups",
          "route53:GetDnssec",
          "route53:GetHostedZone",
          "route53:ListHostedZones",
          "route53:ListQueryLoggingConfigs",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResources",
          "s3:GetAccountPublicAccessBlock",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation",
          "s3:GetBucketLogging",
          "s3:GetBucketObjectLockConfiguration",
          "s3:GetBucketPolicy",
          "s3:GetBucketPolicyStatus",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetBucketTagging",
          "s3:GetBucketVersioning",
          "s3:GetEncryptionConfiguration",
          "s3:ListAllMyBuckets",
          "sns:GetTopicAttributes",
          "sns:ListTagsForResource",
          "sns:ListTopics",
          "sqs:GetQueueAttributes",
          "sqs:ListQueueTags",
          "sqs:ListQueues",
          "wafv2:GetRuleGroup",
          "wafv2:GetWebACL",
          "wafv2:ListResourcesForWebACL",
          "wafv2:ListRuleGroups",
          "wafv2:ListWebACLs"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-global" {
  role       = aws_iam_role.lightlytics-role.name
  policy_arn = aws_iam_policy.lightlytics-policy.arn
}
