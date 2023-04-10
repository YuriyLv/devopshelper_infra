#____________________________________________App
# alarm_up
resource "aws_cloudwatch_metric_alarm" "app_cpu_alarm_up" {
  alarm_name          = "${local.app_name}_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.app_policy_up.arn]
}
# alarm_down
resource "aws_cloudwatch_metric_alarm" "app_cpu_alarm_down" {
  alarm_name          = "${local.app_name}_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "180"
  statistic           = "Average"
  threshold           = "15"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app.name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.app_policy_down.arn]
}
