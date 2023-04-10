#____________________________________________Module_Keys_output

output "external_key_name" {
  value = aws_key_pair.external_key.key_name
}
output "internal_key_name" {
  value = aws_key_pair.internal_key.key_name
}
