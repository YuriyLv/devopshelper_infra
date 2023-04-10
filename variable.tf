#____________________________________________MAIN_JOINT_VARIABLE
variable "environment" {
  default = "prod"
}
variable "purpose" {
  default = "improvement"
}

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


#____________________________________________MAIN_BASTION_VARIABLE
variable "bastion_count" {
  default = "1"
}
variable "bastion_instance_type" {
  default = "t2.micro"
}
variable "bastion_volume_size" {
  default = "8"
}
variable "bastion_user" {
  default = "ec2-user"
}

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

#____________________________________________ELK
variable "elk_count" {
  default = "1"
}
variable "elk_linux" {
  default = "1"
  # 1 - ubuntu
  # other - aws-linux
}
variable "elk_instance_type" {
  default = "t3.small"
}
variable "elk_volume_size" {
  default = "12"
}
variable "elk_user_ubuntu" {
  default = "ubuntu"
}
variable "elk_user_awslinux" {
  default = "ec2-user"
}

#____________________________________________MAIN_KEY_VARIABLE
# for deploy code make key value empty and set variable on terraform cloud
variable "external_key_name" {
  default = "external_key_pub"
}
variable "external_key" {
  default = "-----BEGIN RSA PUBLIC KEY-----MIIBigKCAYEAq3DnhgYgLVJknvDA3clATozPtjI7yauqD4/ZuqgZn4KzzzkQ4BzJar4jRygpzbghlFn0Luk1mdVKzPUgYj0VkbRlHyYfcahbgOHixOOnXkKXrtZW7yWGjXPqy/ZJ/+-----END RSA PUBLIC KEY-----"
  #default = file("/home/dozee/.ssh/external_key.pub")
}
variable "private_internal_key" {
  default = "-----BEGIN RSA PRIVATE KEY-----MIIBigKCAYEAq3DnhgYgLVJknvDA3clATozPtjI7yauqD4/ZuqgZn4KzzzkQ4BzJar4jRygpzbghlFn0Luk1mdVKzPUgYj0VkbRlHyYfcahbgOHixOOnXkKXrtZW7yWGjXPqy/ZJ/+-----END RSA PUBLIC KEY-----"
  #default = file("/home/dozee/.ssh/internal_key")
}
variable "destination_private_internal_key" {
  default = "/home/ec2-user/.ssh/private_internal_key"
}
variable "destination_private_internal_key_ubuntu" {
  default = "/home/ubuntu/private_internal_key.pub"
}
variable "internal_key_name" {
  default = "internal_key_pub"
}
variable "internal_key" {
  default = "-----BEGIN RSA PUBLIC KEY-----MIIBigKCAYEAq3DnhgYgLVJknvDA3clATozPtjI7yauqD4/ZuqgZn4KzzzkQ4BzJar4jRygpzbghlFn0Luk1mdVKzPUgYj0VkbRlHyYfcahbgOHixOOnXkKXrtZW7yWGjXPqy/ZJ/+-----END RSA PUBLIC KEY-----"
  #default = file("/home/dozee/.ssh/internal_key.pub")
}

#____________________________________________MONITOR
variable "monitor_count" {
  default = "1"
}
variable "monitor_linux" {
  default = "1"
  # 1 - ubuntu
  # other - aws-linux
}
variable "monitor_instance_type" {
  default = "t3.small"
}
variable "monitor_volume_size" {
  default = "12"
}
variable "monitor_user_ubuntu" {
  default = "ubuntu"
}
variable "monitor_user_awslinux" {
  default = "ec2-user"
}

