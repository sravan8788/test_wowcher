
locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  region         = data.aws_region.current.name
  name           = "${var.global.namespace}-${var.tags.environment}"
  common_tags    = var.tags
  private_subnet_ids = toset([
    for subnet in data.aws_subnet.private : subnet.id
  ])
  public_subnet_ids = toset([
    for subnet in data.aws_subnet.public : subnet.id
  ])
}

