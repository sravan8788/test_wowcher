resource "aws_lb" "this" {
  name                             = "${var.name}-private-alb"
  internal                         = var.alb_internal
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.private_alb.id]
  subnets                          = var.alb_internal == true ? var.private_subnet_ids : var.public_subnet_ids
  enable_cross_zone_load_balancing = true

  tags = var.tags
}

resource "aws_lb_listener" "alb_lstnr_http" {
  depends_on        = [aws_lb.this]
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"
  tags              = var.tags

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_lstnr_https" {
  depends_on        = [aws_lb.this]
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.cert_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}
