#____________________________________________Role_for_app
resource "aws_iam_role" "app" {
  name               = "${var.environment}_EC2_SSM"
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
resource "aws_iam_role_policy_attachment" "app_ec2_for_ssm" {
  role       = aws_iam_role.app.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "app_ssm" {
  role       = aws_iam_role.app.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
resource "aws_iam_role_policy_attachment" "app_ec2_read_only" {
  role       = aws_iam_role.app.name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}
#____________________________________________AppProfile_for_app_ec2_instances
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.environment}_EC2_SSM"
  role = aws_iam_role.app.name
}
