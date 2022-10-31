resource "aws_security_group" "private_fargate" {
  name        = "${var.name}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 0
    to_port = 65000
    protocol = "TCP"
    security_groups = [aws_security_group.private_alb.id]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = merge(var.tags,
    { Name = "${var.name}-sg" }
  )
}

resource "aws_security_group" "private_alb" {
  name        = "${var.name}-private-alb-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [80, 443]

    content {
      description = "Allow cidr blocks to access alb"
      protocol    = "tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      cidr_blocks = var.alb_internal == true ? [var.vpc_cidr] : ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags,
    { Name = "${var.name}-private-alb-sg" }
  )
}

