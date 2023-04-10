#____________________________________________Role_for_Monitor
resource "aws_iam_role" "monitor" {
  name               = "${var.environment}_Monitor"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "monitor_ec2_for_ssm" {
  role       = aws_iam_role.monitor.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "monitor_ssm" {
  role       = aws_iam_role.monitor.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
resource "aws_iam_role_policy_attachment" "monitor_ec2_read_only" {
  role       = aws_iam_role.monitor.name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}

#____________________________________________Policy_for_Monitor
data "aws_iam_policy_document" "monitor_policy" {
  statement {
    effect    = "Allow"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeRegions",
      "tag:GetTagValues",
      "tag:GetTagKeys"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "monitor_policy" {
  name        = "monitor_policy"
  policy      = data.aws_iam_policy_document.monitor_policy.json
}
#____________________________________________Policy_v2_for_Monitor
resource "aws_iam_policy" "prometheus_policy" {
  name        = "prometheus_policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowPrometheusAccess"
        Effect    = "Allow"
        Action    = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags"
        ]
        Resource  = "*"
        Condition = {
          StringEquals = {
            "ec2:VpcId" = "${var.vpc_id}"
          }
        }
      }
    ]
  })
}
#____________________________________________Attach_new_prometheus_policy_to_monitor role
resource "aws_iam_role_policy_attachment" "prometheus_role_policy_attachment" {
  policy_arn = aws_iam_policy.prometheus_policy.arn
  role       = aws_iam_role.monitor.name
}
#____________________________________________Attach_new_monitor_policy_to_monitor_role
resource "aws_iam_policy_attachment" "monitor_ec2_describe" {
  name       = "${var.environment}_Monitor"
  roles       = [aws_iam_role.monitor.name]
  policy_arn = aws_iam_policy.monitor_policy.arn
}

#____________________________________________Monitor_Instance_Profile
resource "aws_iam_instance_profile" "monitor_profile" {
  name = "${var.environment}_Monitor"
  role = aws_iam_role.monitor.name
}
