#____________________________________________Module_Bastion_variable
variable "region" {}
variable "environment" {}
variable "purpose" {}

variable "bastion_user" {}
variable "bastion_count" {}
variable "bastion_instance_type" {}
variable "bastion_volume_size" {}

variable "external_key_name" {}
variable "private_internal_key" {}
variable "destination_private_internal_key" {}

variable "public_subnet_ids" {}
variable "sg_public_id" {}