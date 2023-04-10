#____________________________________________Module_Network_output
output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public.*.id
}
output "private_subnet_ids" {
  value = aws_subnet.private.*.id
}
output "nat_private_ips" {
  value = aws_nat_gateway.nat.*.private_ip
}
output "nat_public_ips" {
  value = aws_nat_gateway.nat.*.public_ip
}
output "public_subnet_route_ids" {
  value = aws_route_table.public.*.id
}
output "private_subnet_route_ids" {
  value = aws_route_table.private.*.id
}
output "zones" {
  value = var.zones
}
output "sg_private_id" {
  value = aws_security_group.private.id
}
output "sg_public_id" {
  value = aws_security_group.public.id
}
output "sg_https_id"{
  value = aws_security_group.sg_https.id
}
output "sg_rds_id"{
  value = aws_security_group.sg_rds.id
}
