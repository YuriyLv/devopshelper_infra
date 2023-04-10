#____________________________________________MAIN_DEPLOY_VARIABLE
#asg
variable "instance_type" {
  default = "t3.small"
}
variable "volume_size" {
  default = 12
}
variable "device_name" {
  default = "/dev/sda1"
}
variable "launch_template_version" {
  default = "$Latest"
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 2
}
variable "desired_capacity" {
  default = 1
}
variable "subdomain" {
  default = "test"
}
variable "public_zone_name" {
  description = "Public Hosted Zone Name"
  default     = "minmax.click"
}
#StateGitLab_registry
variable "token_registry" {
  default = "glpat-sauQ_1iszVxgEoq1s-W-"  #for read registry
}
variable "user_registry" {
  default = "yuriy.dozer"
}
variable "ci_registry" {
  default = "registry.gitlab.com"
}
variable "ci_project_group" {
  default = "/devopshelper/"
}
variable "ci_project_name_app" {
  default = "devopshelper_infra"
}

