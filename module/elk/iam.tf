#____________________________________________Role_for_Elk
resource "aws_iam_role" "elk" {
  name               = "${var.environment}_elk"
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
resource "aws_iam_role_policy_attachment" "elk_ec2_for_ssm" {
  role       = aws_iam_role.elk.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "elk_ssm" {
  role       = aws_iam_role.elk.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
resource "aws_iam_role_policy_attachment" "elk_ec2_read_only" {
  role       = aws_iam_role.elk.name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}

#____________________________________________Policy_for_elk
data "aws_iam_policy_document" "elk_policy" {
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
resource "aws_iam_policy" "elk_policy" {
  name        = "elk_policy"
  policy      = data.aws_iam_policy_document.elk_policy.json
}
#____________________________________________Policy_v2_for_elk
resource "aws_iam_policy" "logstash_policy" {
  name        = "logstash_policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowlogstashAccess"
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
#____________________________________________Attach_new_logstash_policy_to_elk role
resource "aws_iam_role_policy_attachment" "logstash_role_policy_attachment" {
  policy_arn = aws_iam_policy.logstash_policy.arn
  role       = aws_iam_role.elk.name
}
#____________________________________________Attach_new_elk_policy_to_elk_role
resource "aws_iam_policy_attachment" "elk_ec2_describe" {
  name       = "${var.environment}_elk"
  roles       = [aws_iam_role.elk.name]
  policy_arn = aws_iam_policy.elk_policy.arn
}

#____________________________________________Elk_Instance_Profile
resource "aws_iam_instance_profile" "elk_profile" {
  name = "${var.environment}_elk"
  role = aws_iam_role.elk.name
}
