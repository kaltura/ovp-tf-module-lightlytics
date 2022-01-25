resource "aws_vpc_endpoint" "lambda_send_url" {
  vpc_id                  = var.vpc_id
  service_name            = var.lightlytics_endpoint_service_name
  subnet_ids              = [var.endpoint_subnet_ids]
  private_dns_enabled     = true
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    aws_security_group.allow_443_outbound.id
  ]
}
