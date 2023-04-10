#____________________________________________Backend_s3
terraform {
  backend "s3" {
    region         = "ca-central-1"
    bucket         = "dev-ops-hel-per"
    key            = "prod/terraform.tfstate"
    dynamodb_table = "dev-ops-hel-per"
  }
}
#____________________________________________Provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Purpose     = var.purpose
    }
  }
}
#____________________________________________Versioning
module "versioning" {
  source = "./module/versioning"
}
#____________________________________________Keys
module "keys" {
  source = "./module/keys"

  external_key_name = var.external_key_name
  external_key      = var.external_key


  internal_key_name = var.internal_key_name
  internal_key      = var.internal_key
}
#____________________________________________Network
module "network" {
  source      = "./module/network"
  region      = var.region
  environment = var.environment
  purpose     = var.purpose

  zones                  = var.zones
  vpc_cidr               = var.vpc_cidr
  has_single_nat_gateway = var.has_single_nat_gateway
  my_ip                  = var.my_ip
}

#____________________________________________Bastion
module "bastion" {
  source = "./module/bastion"

  region      = var.region
  environment = var.environment
  purpose     = var.purpose

  bastion_user          = var.bastion_user
  bastion_count         = var.bastion_count
  bastion_instance_type = var.bastion_instance_type
  bastion_volume_size   = var.bastion_volume_size

  external_key_name                = module.keys.external_key_name
  private_internal_key             = var.private_internal_key
  destination_private_internal_key = var.destination_private_internal_key

  public_subnet_ids = module.network.public_subnet_ids
  sg_public_id      = module.network.sg_public_id

  depends_on = [module.network, module.keys]
}

#____________________________________________Rds
module "rds" {
  source = "./module/rds"

  region                    = var.region
  environment               = var.environment
  purpose                   = var.purpose
  create_db_instance        = var.create_db_instance
  create_db_parameter_group = var.create_db_parameter_group
  rds_identifier            = var.rds_identifier
  rds_instance_class        = var.rds_instance_class
  engine                    = var.engine
  family                    = var.family
  major_engine_version      = var.major_engine_version
  rds_storage_size          = var.rds_storage_size
  rds_storage_type          = var.rds_storage_type
  engine_version            = var.engine_version
  db_name                   = var.db_name
  username                  = var.username
  db_password               = var.db_password
  rds_parameters            = var.rds_parameters
  private_subnet_ids        = module.network.private_subnet_ids
  sg_rds_id                 = module.network.sg_rds_id

  depends_on = [module.network]
}

#____________________________________________Ci_Cd
module "ci_cd" {
  source = "./module/ci_cd"

  region      = var.region
  environment = var.environment
  purpose     = var.purpose

  ci_cd_user          = var.ci_cd_user
  ci_cd_count         = var.ci_cd_count
  ci_cd_instance_type = var.ci_cd_instance_type
  ci_cd_volume_size   = var.ci_cd_volume_size

  internal_key_name                = module.keys.internal_key_name
  private_internal_key             = var.private_internal_key
  destination_private_internal_key = var.destination_private_internal_key

  private_subnet_ids = module.network.private_subnet_ids
  sg_private_id      = module.network.sg_private_id

  depends_on = [module.network, module.keys]
}

#____________________________________________Monitor
module "monitor" {
  source = "./module/monitor"

  region      = var.region
  environment = var.environment
  purpose     = var.purpose

  monitor_user_ubuntu   = var.monitor_user_ubuntu
  monitor_user_awslinux = var.monitor_user_awslinux
  monitor_count         = var.monitor_count
  monitor_instance_type = var.monitor_instance_type
  monitor_volume_size   = var.monitor_volume_size
  monitor_linux         = var.monitor_linux

  internal_key_name                         = module.keys.internal_key_name
  private_internal_key                      = var.private_internal_key
  destination_private_internal_key_ubuntu   = var.destination_private_internal_key_ubuntu
  destination_private_internal_key_awslinux = var.destination_private_internal_key

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  sg_private_id      = module.network.sg_private_id

  depends_on = [module.network, module.keys]
}

#____________________________________________Elk
module "elk" {
  source = "./module/elk"

  region      = var.region
  environment = var.environment
  purpose     = var.purpose

  elk_user_ubuntu   = var.elk_user_ubuntu
  elk_user_awslinux = var.elk_user_awslinux
  elk_count         = var.elk_count
  elk_instance_type = var.elk_instance_type
  elk_volume_size   = var.elk_volume_size
  elk_linux         = var.elk_linux

  internal_key_name                         = module.keys.internal_key_name
  private_internal_key                      = var.private_internal_key
  destination_private_internal_key_ubuntu   = var.destination_private_internal_key_ubuntu
  destination_private_internal_key_awslinux = var.destination_private_internal_key

  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids
  sg_private_id      = module.network.sg_private_id

  depends_on = [module.network, module.keys]
}

#____________________________________________Deploy
module "deploy" {
  source = "./module/deploy"

  region      = var.region
  environment = var.environment
  purpose     = var.purpose

  instance_type           = var.instance_type
  volume_size             = var.volume_size
  device_name             = var.device_name
  launch_template_version = var.launch_template_version
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
  subdomain               = var.subdomain
  public_zone_name        = var.public_zone_name
  token_registry          = var.token_registry
  user_registry           = var.user_registry
  ci_registry             = var.ci_registry
  ci_project_group        = var.ci_project_group
  ci_project_name_app     = var.ci_project_name_app
  private_subnet_ids      = module.network.private_subnet_ids
  sg_https                = module.network.sg_https_id
  public_subnet_ids       = module.network.public_subnet_ids
  vpc_id                  = module.network.vpc_id
  public_zone_id          = module.network.sg_public_id
  sg_private              = module.network.sg_private_id
  internal_key_name       = var.internal_key_name
}