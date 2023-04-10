#____________________________________________ Main_ALB
resource "aws_lb" "alb" {
  name               = "${var.environment}-app"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_https]
  subnets            = var.public_subnet_ids
}
#____________________________________________Listener_load_balancer
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ssl.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_app.arn
  }
  depends_on = [aws_acm_certificate_validation.cert]
}

#____________________________________________App_redirect_http_to_https
resource "aws_lb_listener" "http_app" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "redirect"
    redirect {
      protocol         = "HTTPS"
      port             = "443"
      status_code      = "HTTP_301"
    }
  }
  depends_on = [aws_lb_listener.app]
}
