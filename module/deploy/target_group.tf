#__________________________________App_target_group
resource "aws_alb_target_group" "target_app" {
  name        = local.app_name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = "2"
    path                = "/"
    interval            = 5
    matcher             = "200,301,401"
  }
}
