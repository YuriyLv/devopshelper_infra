#____________________________________________Module_RDS_variable
variable "region" {}
variable "environment" {}
variable "purpose" {}
variable "create_db_instance" {}
variable "create_db_parameter_group" {}
variable "rds_identifier" {}
variable "rds_instance_class" {}
variable "engine" {}
variable "family" {}
variable "major_engine_version" {}
variable "rds_storage_size" {}
variable "rds_storage_type" {}
variable "engine_version" {}
variable "db_password" {}
variable "db_name" {}
variable "username" {}
variable "private_subnet_ids" {}
variable "sg_rds_id" {}
variable "rds_parameters" {
  type = list(any)
  default = []
}
