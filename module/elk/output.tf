#____________________________________________Module_Elk_output
output "elk_ip" {
  value = aws_instance.elk.*.private_ip
}