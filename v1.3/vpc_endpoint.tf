resource "aws_vpc_endpoint" "lambda_send_url" {
  vpc_id                  = var.vpc_id
  service_name            = var.lightlytics_endpoint_service_name
  for_each                = var.endpoint_subnet_ids
  subnet_ids              = [each.value]
  private_dns_enabled     = true
}
