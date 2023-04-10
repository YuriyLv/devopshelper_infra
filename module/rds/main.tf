module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "5.3.0"

  create_db_instance        = var.create_db_instance
  create_db_parameter_group = var.create_db_parameter_group
  parameters                = var.rds_parameters
  identifier                = "${var.environment}-${var.rds_identifier}"
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.rds_instance_class
  allocated_storage         = var.rds_storage_size
  storage_type              = var.rds_storage_type

  password = var.db_password
  db_name  = var.db_name
  username = var.username
  port     = "3306"

  #____________________________________________Create_random_password_variable_should_be_set_to_true_if_need_random_pass
  create_random_password = false
  vpc_security_group_ids = [var.sg_rds_id]

  #____________________________________________DB_subnet_group
  create_db_subnet_group = true
  subnet_ids             = var.private_subnet_ids

  #____________________________________________DB_parameter_group
  family = var.family

  #____________________________________________DB option group
  major_engine_version = var.major_engine_version

  #____________________________________________Database_Deletion_Protection
  deletion_protection = false
  skip_final_snapshot = true

  tags = {
    Name = "${var.environment}-${var.rds_identifier}-RDS-insatnce"
  }
}