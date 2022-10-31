data "aws_caller_identity" "current" {}

data "aws_region" "current" {
}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_acm_certificate" "issued" {
  domain   = var.cert_name
  statuses = ["ISSUED"]
}


data "aws_subnet" "public" {
  for_each = toset(var.public_subnet_cidrs)
  cidr_block = each.key
}

data "aws_subnet" "private" {
  for_each = toset(var.private_subnet_cidrs)
  cidr_block = each.key
}

data "aws_route53_zone" "selected" {
  name         = var.domain
}

data "aws_ssm_parameter" "db_username" {
  name = "/${var.tags["environment"]}/${var.tags["project"]}/db_username"
}

data "aws_ssm_parameter" "db_password" {
  name = "/${var.tags["environment"]}/${var.tags["project"]}/db_password"
}
