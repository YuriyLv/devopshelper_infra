#____________________________________________Module_Bastion_output
output "bastion_ip" {
  value = aws_instance.bastion.*.public_ip
}