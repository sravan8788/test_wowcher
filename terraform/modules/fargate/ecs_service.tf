resource "aws_ecs_service" "service" {
  name                              = var.name
  cluster                           = aws_ecs_cluster.fargate.name
  task_definition                   = "${aws_ecs_task_definition.definition.family}:${aws_ecs_task_definition.definition.revision}"
  desired_count                     = var.desired_count
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 240

  # Ensure we only have 1 deployed at once
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  load_balancer {
    target_group_arn = aws_alb_target_group.tg.arn
    container_name   = var.name
    container_port   = var.listener_port
  }
  network_configuration {
    subnets = flatten(["${var.private_subnet_ids}"])
  }
}
