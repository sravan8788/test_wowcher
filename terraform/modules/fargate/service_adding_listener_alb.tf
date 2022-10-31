resource "aws_alb_target_group" "tg" {
  name                 = "${var.name}-alb-tg"
  port                 = var.listener_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 30
  target_type          =   "ip"
  tags                 = var.tags

  health_check {
//    port                = local.health_check_port
    healthy_threshold   = "5"
    unhealthy_threshold = "5"
    interval            = "120"
    matcher             = var.health_check_return_code
    path                = var.health_check_return_path
    protocol            = "HTTP"
    timeout             = "119"
  }
}

resource "aws_alb_listener_rule" "http_path" {
  listener_arn = aws_lb_listener.alb_lstnr_https.arn

  action {
    target_group_arn = aws_alb_target_group.tg.arn
    type             = "forward"
  }

  condition {
    host_header {
      values = [
        var.domain
      ]
    }
  }
}