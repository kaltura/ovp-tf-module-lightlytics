resource "aws_vpc_endpoint" "lambda_send_url" {
  vpc_id                  = var.vpc_id
  service_name            = var.lightlytics_endpoint_service_name
  subnet_ids              = values[var.endpoint_subnet_ids]
  private_dns_enabled     = true
}
