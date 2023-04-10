#____________________________________________Module_Ci_Cd_output
output "ci_cd_ip" {
  value = aws_instance.ci_cd.*.private_ip
}