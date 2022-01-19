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
          "iam:ListInstanceProfiles",
          "ec2:DescribeSecurityGroups",
          "sqs:GetQueueAttributes",
          "rds:DescribeDbSubnetGroups",
          "ec2:DescribeNetworkAcls",
          "s3:GetBucketVersioning",
          "ec2:GetManagedPrefixListEntries",
          "elasticloadbalancing:DescribeLoadBalancers",
          "iam:GetPolicyVersion",
          "sqs:ListQueues",
          "elasticache:DescribeCacheSubnetGroups",
          "lambda:ListTags",
          "lambda:ListFunctions",
          "dynamodb:DescribeTable",
          "iam:GetAccountAuthorizationDetails",
          "eks:DescribeNodegroup",
          "iam:GetRole",
          "kafka:ListClusters",
          "dynamodb:ListTagsOfResource",
          "ec2:DescribeLaunchTemplateVersions",
          "sns:ListTagsForResource",
          "ec2:DescribeVpcPeeringConnections",
          "elasticloadbalancing:DescribeRules",
          "iam:ListRoleTags",
          "s3:GetBucketPublicAccessBlock",
          "ec2:DescribeNetworkInterfaces",
          "autoscaling:DescribeLaunchConfigurations",
          "eks:ListNodegroups",
          "iam:ListUserTags",
          "dynamodb:ListTables",
          "ecs:DescribeTasks",
          "kinesis:ListStreams",
          "sqs:ListQueueTags",
          "ecs:DescribeContainerInstances",
          "iam:ListRoles",
          "s3:GetBucketAcl",
          "elasticloadbalancing:DescribeTags",
          "sns:GetTopicAttributes",
          "ec2:DescribeRouteTables",
          "iam:GetPolicy",
          "ec2:DescribeVpcs",
          "ec2:DescribeEgressOnlyInternetGateways",
          "iam:GetRolePolicy",
          "ecs:ListClusters",
          "s3:ListAllMyBuckets",
          "iam:ListRolePolicies",
          "ec2:DescribeVolumes",
          "ecs:DescribeClusters",
          "elasticache:DescribeCacheClusters",
          "iam:ListUsers",
          "kinesis:ListTagsForStream",
          "ecs:ListTasks",
          "autoscaling:DescribeAutoScalingGroups",
          "ec2:DescribeNatGateways",
          "ec2:DescribeSubnets",
          "s3:GetEncryptionConfiguration",
          "ec2:DescribeInternetGateways",
          "s3:GetBucketTagging",
          "ecs:ListTagsForResource",
          "ec2:DescribeInstances",
          "rds:DescribeDbInstances",
          "iam:ListAttachedUserPolicies",
          "iam:ListPolicies",
          "kinesis:DescribeStream",
          "eks:DescribeCluster",
          "iam:ListAttachedGroupPolicies",
          "elasticloadbalancing:DescribeTargetHealth",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy",
          "s3:GetBucketLogging",
          "ecs:ListTaskDefinitions",
          "ec2:DescribeFlowLogs",
          "s3:GetBucketPolicyStatus",
          "ecs:ListContainerInstances",
          "ecs:DescribeTaskDefinition",
          "ec2:DescribeAddresses",
          "ec2:DescribeTransitGateways",
          "s3:GetAccountPublicAccessBlock",
          "elasticloadbalancing:DescribeListeners",
          "ec2:DescribeManagedPrefixLists",
          "dynamodb:DescribeContinuousBackups",
          "ecs:ListServices",
          "elasticache:ListTagsForResource",
          "elasticloadbalancing:DescribeTargetGroups",
          "iam:ListAttachedRolePolicies",
          "eks:ListClusters",
          "ec2:DescribeVpcEndpoints",
          "iam:GetUserPolicy",
          "iam:ListGroups",
          "sns:ListTopics",
          "iam:GetInstanceProfile",
          "ec2:DescribeTags",
          "iam:ListUserPolicies",
          "iam:ListGroupsForUser",
          "ecs:DescribeServices"
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
