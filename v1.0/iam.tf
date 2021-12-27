###############------------Global-----------#############
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


resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-global" {
  role       = aws_iam_role.lightlytics-role.name
  policy_arn = aws_iam_policy.lightlytics-policy.arn
}



###############----------Init-------------#############

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



resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-init" {
  role       = aws_iam_role.lightlytics-init-role.name
  policy_arn = aws_iam_policy.lightlytics-init-policy.arn
}



###########------------Flow logs-----------#################
resource "aws_iam_role" "lightlytics-FlowLogs-lambda-role" {
  count = var.ShouldCollectFLowLogs ? 1 : 0
  name = "${var.env_name_prefix}-lightlytics-FlowLogs-role"
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

resource "aws_iam_policy" "lightlytics-FlowLogs-lambda-policy" {
  count = var.ShouldCollectFLowLogs ? 1 : 0
  name   = "${var.env_name_prefix}-lightlytics-FlowLogs-lambda-policy"
  path   = "/"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        Action   = [
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
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}

resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-flow-logs" {
  count = var.ShouldCollectFLowLogs ? 1 : 0
  role       = aws_iam_role.lightlytics-FlowLogs-lambda-role.name
  policy_arn = aws_iam_policy.lightlytics-FlowLogs-lambda-policy.arn
}

##############-------Flow Logs Cloud Watch---------###########

resource "aws_iam_role" "lightlytics-FlowLogs-CloudWatch-role" {
  name = "${var.env_name_prefix}-lightlytics-FlowLogs-CloudWatch-role"
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


resource "aws_iam_policy" "lightlytics-FlowLogs-CloudWatch-policy" {
  name   = "${var.env_name_prefix}-lightlytics-FlowLogs-CloudWatch-policy"
  path   = "/"
  policy = <<EOF
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        Action   = [
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
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
EOF
}


resource "aws_iam_role_policy_attachment" "lightlytics-role-attach-cloud-watch" {
  count = var.ShouldCollectFLowLogs ? 1 : 0
  role       = aws_iam_role.lightlytics-FlowLogs-CloudWatch-role.name
  policy_arn = aws_iam_policy.lightlytics-FlowLogs-CloudWatch-policy.arn
}