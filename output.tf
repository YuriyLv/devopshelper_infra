#____________________________________________MAIN_OUTPUT
output "bastion_ip" {
  value = module.bastion.bastion_ip
}
output "ci_cd_ip" {
  value = module.ci_cd.ci_cd_ip
}
output "monitor_ip" {
  value = module.monitor.monitor_ip
}
output "elk_ip" {
  value = module.elk.elk_ip
}
output "db_instance_address" {
  value = module.rds.db_instance_address
}
output "db_database_name" {
  value = module.rds.db_database_name
}
output "db_instance_username" {
  sensitive = true
  value = module.rds.db_instance_username
}
output "db_instance_password" {
  sensitive = true
  value     = module.rds.db_instance_password
}
output "launch_template_app" {
  sensitive = true
  value     = module.deploy.launch_template_app
}
