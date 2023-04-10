#____________________________________________Role_for_CI/CD
resource "aws_iam_role" "ci_cd" {
  name               = "${var.environment}_CI_CD"
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
resource "aws_iam_role_policy_attachment" "ci_cd_ec2_for_ssm" {
  role       = aws_iam_role.ci_cd.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "ci_cd_ssm" {
  role       = aws_iam_role.ci_cd.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
resource "aws_iam_role_policy_attachment" "ci_cd_ec2_read_only" {
  role       = aws_iam_role.ci_cd.name
  policy_arn = data.aws_iam_policy.ec2_read_only.arn
}
#____________________________________________CI/CD_Instance_Profile
resource "aws_iam_instance_profile" "ci_cd_profile" {
  name = "${var.environment}_CI_CD"
  role = aws_iam_role.ci_cd.name
}
