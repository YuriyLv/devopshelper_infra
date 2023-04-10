#____________________________________________MONITOR
variable "monitor_count" {
  default = "1"
}
variable "monitor_linux" {
  default = "1"
  # 1 - ubuntu
  # other - aws-linux
}
variable "monitor_instance_type" {
  default = "t3.small"
}
variable "monitor_volume_size" {
  default = "12"
}
variable "monitor_user_ubuntu" {
  default = "ubuntu"
}
variable "monitor_user_awslinux" {
  default = "ec2-user"
}