#____________________________________________Module_Ci_Cd_variable
variable "region" {}
variable "environment" {}
variable "purpose" {}

variable "vpc_id" {}

variable "monitor_user_ubuntu" {}
variable "monitor_user_awslinux" {}

variable "monitor_count" {}
variable "monitor_instance_type" {}
variable "monitor_volume_size" {}
variable "monitor_linux" {}

variable "internal_key_name" {}
variable "private_internal_key" {}
variable "destination_private_internal_key_awslinux" {}
variable "destination_private_internal_key_ubuntu" {}

variable "private_subnet_ids" {}
variable "sg_private_id" {}

