#____________________________________________MAIN_CI_CD_VARIABLE
variable "ci_cd_count" {
  default = "1"
}
variable "ci_cd_instance_type" {
  default = "t3.small"
}
variable "ci_cd_volume_size" {
  default = "10"
}
variable "ci_cd_user" {
  default = "ec2-user"
}