resource "null_resource" "lightlytics-enable-account" {
  provisioner "local-exec" {
      command = <<EOF
        curl -X POST '${var.lightlytics_api_url}/graphql \
          -H 'Content-Type: application/json' \
          -H 'Authorization: Bearer ${var.lightlytics_auth_token}' \
          -d '{
                "query":"mutation AccountAcknowledge($input: AccountAckInput){\r\n accountAcknowledge(account: $input)\r\n }",
                "variables": {
                  "input": {
                    "lightlytics_internal_account_id":"${var.LightlyticsInternalAccountId}",
                    "role_arn":"arn:aws:iam::"${var.aws_account_id}":role/"${var.env_name_prefix}-lightlytics-role"",
                    "account_type":"AWS","account_aliases":"","aws_account_id":"${var.aws_account_id}","stack_region":"${var.RegionsToDeploy}",
                    "stack_id":"","init_stack_version":1}}}'
EOF
      depends_on = [aws_iam_role.lightlytics-role]
  }
}
