resource "aws_iam_role" "lightlytics-role" {
  name = "${var.env_name_prefix}-lightlytics-role"
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
  name   = "${var.env_name_prefix}-lightlytics-policy"
  path   = "/"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        Action   = [
          "dynamodb:DescribeContinuousBackups",
          "dynamodb:ListTagsOfResource",
          "autoscaling:DescribeAutoScalingGroups",
          "s3:GetEncryptionConfiguration",
          "lambda:ListTags",
          "ec2:DescribeNetworkInterfaces",
          "kafka:ListClusters",
          "rds:DescribeDbSubnetGroups",
          "iam:GetPolicyVersion",
          "ecs:DescribeContainerInstances",
          "kinesis:DescribeStream",
          "ecs:DescribeTaskDefinition",
          "ec2:DescribeNatGateways",
          "iam:ListRoleTags",
          "sqs:ListQueueTags",
          "s3:GetBucketTagging",
          "iam:ListUsers",
          "dynamodb:ListTables",
          "kinesis:ListTagsForStream",
          "ec2:DescribeRouteTables",
          "elasticloadbalancing:DescribeRules",
          "ec2:GetManagedPrefixListEntries",
          "s3:GetBucketLocation",
          "ec2:DescribeSecurityGroups",
          "sqs:GetQueueAttributes",
          "elasticloadbalancing:DescribeListeners",
          "eks:DescribeCluster",
          "iam:ListAttachedUserPolicies",
          "iam:ListAttachedGroupPolicies",
          "s3:GetBucketAcl",
          "iam:GetPolicy",
          "ecs:DescribeServices",
          "iam:GetRolePolicy",
          "ecs:ListTaskDefinitions",
          "eks:ListClusters",
          "rds:DescribeDbInstances",
          "ec2:DescribeLaunchTemplateVersions",
          "s3:GetBucketVersioning",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeVolumes",
          "iam:ListRoles",
          "ec2:DescribeManagedPrefixLists",
          "ecs:ListServices",
          "s3:GetAccountPublicAccessBlock",
          "iam:ListGroups",
          "iam:ListRolePolicies",
          "elasticloadbalancing:DescribeTargetHealth",
          "iam:ListGroupsForUser",
          "ec2:DescribeTags",
          "autoscaling:DescribeLaunchConfigurations",
          "elasticloadbalancing:DescribeTargetGroups",
          "ecs:ListContainerInstances",
          "ec2:DescribeTransitGateways",
          "s3:GetBucketPolicyStatus",
          "s3:GetBucketPublicAccessBlock",
          "ecs:ListTagsForResource",
          "ecs:DescribeClusters",
          "ec2:DescribeEgressOnlyInternetGateways",
          "ec2:DescribeNetworkAcls",
          "iam:ListUserTags",
          "ec2:DescribeVpcEndpoints",
          "ecs:ListTasks",
          "iam:GetRole",
          "elasticloadbalancing:DescribeLoadBalancers",
          "ecs:ListClusters",
          "dynamodb:DescribeTable",
          "ec2:DescribeInternetGateways",
          "iam:ListPolicies",
          "kinesis:ListStreams",
          "elasticloadbalancing:DescribeTags",
          "s3:GetBucketPolicy",
          "ec2:DescribeAddresses",
          "sqs:ListQueues",
          "ec2:DescribeFlowLogs",
          "s3:ListAllMyBuckets",
          "ecs:DescribeTasks",
          "ec2:DescribeInstances",
          "iam:GetAccountAuthorizationDetails",
          "ec2:DescribeSubnets",
          "s3:GetBucketLogging",
          "ec2:DescribeVpcs",
          "iam:ListInstanceProfiles",
          "iam:ListAttachedRolePolicies",
          "lambda:ListFunctions",
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}


resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.lightlytics-role.name
  policy_arn = aws_iam_policy.lightlytics-policy.arn
}