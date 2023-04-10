
#____________________________________________State
variable "region" {
  default = "ca-central-1"
}
variable "environment_name" {
  default = "main"
}
variable "environment_id" {
  default = "prod"
}
variable "state_bucket" {
  default = "dev-ops-hel-per"
}
variable "table_name" {
  default = "dev-ops-hel-per"
}
variable "purpose" {
  default = "developing"
}
variable "state_bucket_key" {
  default = "state-bucket/terraform.tfstate"
}
