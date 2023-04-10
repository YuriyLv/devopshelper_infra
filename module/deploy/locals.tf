#__________________________________locals_for_app_image
locals {
  app_name  = "${var.environment}-app"
  app_image = "-p 80:80 ${var.ci_registry}${var.ci_project_group}${var.ci_project_name_app}:latest"
}