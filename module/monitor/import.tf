#____________________________________________AWS_Linux_Ami
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }
}
#____________________________________________Ubuntu_Linux_Ami
data "aws_ami" "latest_ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
#____________________________________________Ec2_ssm
data "aws_iam_policy" "ec2_for_ssm" {
  name = "AmazonEC2RoleforSSM"
}
#____________________________________________Ssm
data "aws_iam_policy" "ssm" {
  name = "AmazonSSMManagedInstanceCore"
}
#____________________________________________ec2_read
data "aws_iam_policy" "ec2_read_only" {
  name = "AmazonEC2ReadOnlyAccess"
}