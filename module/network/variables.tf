#____________________________________________Module_Network_variable
variable "region" {}
variable "environment" {}
variable "purpose" {}
variable "zones" {}
variable "vpc_cidr" {}
variable "my_ip" {}
variable "has_single_nat_gateway" {
  type        = bool
  default     = true
}
