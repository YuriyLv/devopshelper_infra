#__________________________________App
resource "aws_autoscaling_group" "app" {
  name = local.app_name
  launch_template {
    id      = aws_launch_template.app.id
    version = var.launch_template_version
  }
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.private_subnet_ids
  lifecycle {
    ignore_changes        = [load_balancers, target_group_arns]
    create_before_destroy = true
  }
  dynamic "tag" {
    for_each = {
      Name        = local.app_name
      Environment = var.environment
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_target" {
  autoscaling_group_name = aws_autoscaling_group.app.id
  lb_target_group_arn    = aws_alb_target_group.target_app.arn
  depends_on             = [aws_autoscaling_group.app]
}
