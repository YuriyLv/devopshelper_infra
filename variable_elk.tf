#____________________________________________ELK
variable "elk_count" {
  default = "1"
}
variable "elk_linux" {
  default = "1"
  # 1 - ubuntu
  # other - aws-linux
}
variable "elk_instance_type" {
  default = "t3.small"
}
variable "elk_volume_size" {
  default = "12"
}
variable "elk_user_ubuntu" {
  default = "ubuntu"
}
variable "elk_user_awslinux" {
  default = "ec2-user"
}