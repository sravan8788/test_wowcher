
module "wowcher_app" {
  source                    = "./modules/fargate"
  name                      = "${local.name}-app"
  listener_port             = var.app_port
  tags                      = local.common_tags
  aws_account_id            = local.aws_account_id
  region                    = local.region
  docker_image              = "simple-flask-app"
  docker_image_tag          = "latest"
  cert_arn                  = data.aws_acm_certificate.issued.arn
  vpc_id                    = data.aws_vpc.selected.id
  vpc_cidr                  = data.aws_vpc.selected.cidr_block
  domain                    = var.domain
  route53_zone_id           = data.aws_route53_zone.selected.zone_id
  alb_internal              = true
  health_check_return_path  = "/healthcheck/"
  public_subnet_ids         = local.public_subnet_ids
  private_subnet_ids        = local.private_subnet_ids
  scale_target_max_capacity = 4
  task-env-vars             = [
                                { ENV_NAME = var.tags.environment },
  ]
  task-env-secrets          = [
                                { DB_PASSWORD = data.aws_ssm_parameter.db_password.arn },
                                { DBHOST = data.aws_ssm_parameter.db_username.arn }
  ]
}
