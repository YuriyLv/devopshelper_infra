#____________________________________________MAIN_RDS_VARIABLE
variable "create_db_instance" {
  default = true
}
variable "create_db_parameter_group" {
  default = true
}
variable "rds_identifier" {
  default = "main"
}
variable "rds_instance_class" {
  default = "db.t3.micro"
}
variable "engine" {
  default = "mysql"
}
variable "family" {
  default = "mysql8.0"
}
variable "major_engine_version" {
  default = "8.0"
}
variable "rds_storage_size" {
  default = 25
}
variable "rds_storage_type" {
  default = "gp2"
}
variable "engine_version" {
  default = "8.0.31"
}
variable "rds_parameters" {
  type = list(any)
  default = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}
variable "db_name" {
  default = "DevOpsHelPer"
}
variable "username" {
  default = "root"
}
variable "db_password" {
  default = "12345678"
}
