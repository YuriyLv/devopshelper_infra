#____________________________________________MAIN_BASTION_VARIABLE
variable "bastion_count" {
  default = "1"
}
variable "bastion_instance_type" {
  default = "t2.micro"
}
variable "bastion_volume_size" {
  default = "8"
}
variable "bastion_user" {
  default = "ec2-user"
}