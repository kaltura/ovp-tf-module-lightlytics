resource "aws_security_group" "allow_443_outbound" {
  description = "Allow 443 outbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}