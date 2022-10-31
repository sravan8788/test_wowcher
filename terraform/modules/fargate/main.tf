# Create AWS Fargate application
resource "aws_ecs_cluster" "fargate" {
  name  = "${var.name}-cluster"
  tags  = var.tags
}

data "aws_caller_identity" "current" {}

data "template_file" "task-definition-env" {
  template = file("${path.module}/templates/task_definition_env.json.tmpl")
  count    = length(var.task-env-vars)

  vars = {
    environment_key   = element(keys(var.task-env-vars[count.index]), 0)
    environment_value = element(values(var.task-env-vars[count.index]), 0)
  }
}

data "template_file" "task-definition-secret" {
  template = file("${path.module}/templates/task_definition_secret.json.tmpl")
  count    = length(var.task-env-secrets)

  vars = {
    secret_key   = element(keys(var.task-env-secrets[count.index]), 0)
    secret_value = element(values(var.task-env-secrets[count.index]), 0)
  }
}


data "template_file" "task-definition" {
  template = file("${path.module}/templates/task_definition_main.json.tpl")

  vars = {
    aws_account_id   = data.aws_caller_identity.current.account_id
    region           = var.region
    docker_image_tag = "latest"
    docker_image     = var.docker_image
    name             = var.name
//    host_port        = 0
    host_port        = var.listener_port
    container_port   = var.listener_port
    log_group        = aws_cloudwatch_log_group.this.name
    environment      = join(",", data.template_file.task-definition-env.*.rendered)
    secrets          = join(",", data.template_file.task-definition-secret.*.rendered)
  }
}

resource "aws_ecs_task_definition" "definition" {
  family                   = var.name
  container_definitions    = data.template_file.task-definition.rendered
  execution_role_arn       = aws_iam_role.fargate_execution_role.arn
  task_role_arn            = aws_iam_role.fargate_task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  tags = merge(
    var.tags,
    {
      "Name"        = var.name
      "Description" = "Task definition for ${var.name}"
    },
  )

}
