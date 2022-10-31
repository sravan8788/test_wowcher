#### Fargate Task
Module that allows creation of a scheduled Fargate Task launched on private vpc. Accepts count variable which means that can be created in only certain env i.e. dev if required (annoyingly only done at the module level in tf > 13) and cron expression to specify how often task should be executed. Has default cloud watch logs and can post to loki logger directly from script using loki logger. Uses latest ECR image of provided ecr repo.

## Example Basic Usage 
```terraform
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
  alb_internal              = false
  public_subnet_ids         = local.public_subnet_ids
  private_subnet_ids        = local.private_subnet_ids
  scale_target_max_capacity = 4
  task-env-vars             = [
                                { ENV_NAME = var.tags.environment },
                                //    { DATABASE = data.terraform_remote_state.rds.outputs.rds.rds_db },
  ]
  task-env-secrets          = [
                                { DB_PASSWORD = data.aws_ssm_parameter.db_password.arn },
                                { DBHOST = data.aws_ssm_parameter.db_host.arn }
  ]
}
```
