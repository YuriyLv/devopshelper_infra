#____________________________________________Module_Ci_Cd_variable
variable "region" {}
variable "environment" {}
variable "purpose" {}

variable "vpc_id" {}

variable "elk_user_ubuntu" {}
variable "elk_user_awslinux" {}

variable "elk_count" {}
variable "elk_instance_type" {}
variable "elk_volume_size" {}
variable "elk_linux" {}

variable "internal_key_name" {}
variable "private_internal_key" {}
variable "destination_private_internal_key_awslinux" {}
variable "destination_private_internal_key_ubuntu" {}

variable "private_subnet_ids" {}
variable "sg_private_id" {}

