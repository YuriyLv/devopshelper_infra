#____________________________________________Module_Monitor_output
output "monitor_ip" {
  value = aws_instance.monitor.*.private_ip
}