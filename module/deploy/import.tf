#__________________________________Linux_Ami
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }
}
#__________________________________Dommain_name
data "aws_route53_zone" "public" {
  name = var.public_zone_name
}
#__________________________________Ssm_roles
data "aws_iam_policy" "ec2_read_only" {
  name = "AmazonEC2ReadOnlyAccess"
}
data "aws_iam_policy" "ec2_for_ssm" {
  name = "AmazonEC2RoleforSSM"
}
data "aws_iam_policy" "ssm" {
  name = "AmazonSSMManagedInstanceCore"
}