#__________________________________App
# app down policy
resource "aws_autoscaling_policy" "app_policy_down" {
  name                   = "${local.app_name}_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}
# app up policy
resource "aws_autoscaling_policy" "app_policy_up" {
  name                   = "${local.app_name}_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.app.name
}
