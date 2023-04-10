#____________________________________________MAIN_NETWORK_VARIABLE
variable "region" {
  default = "ca-central-1"
}
variable "has_single_nat_gateway" {
  description = "Toggle for environments to use 1 NAT gateway for all AZs"
  type        = bool
  default     = true   #(True - save money)
}
variable "zones" {
  type = list(string)
  default = [
    "ca-central-1a",
    "ca-central-1b",
    "ca-central-1d"
  ]
  description = "List of availability zones"
}
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
}
variable "my_ip" {
  default = "176.117.187.49/32"
}