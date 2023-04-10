#____________________________________________Role_for_Bastion
resource "aws_iam_role" "ssm" {
  name               = "${var.environment}-ssm"
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
resource "aws_iam_role_policy_attachment" "ec2_for_ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.ec2_for_ssm.arn
}
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
#____________________________________________Bastion_Instance_Profile
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.environment}-Bastion"
  role = aws_iam_role.ssm.name
}