#____________________________________________Internet_gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment}_Internet_Gateway"
  }
}

#____________________________________________Elastic_IPs_for_NAT
resource "aws_eip" "nat" {
  count = var.has_single_nat_gateway ? 1 : length(var.zones)
  vpc   = true
}

#____________________________________________Attach_managed_NAT
resource "aws_nat_gateway" "nat" {
  count         = var.has_single_nat_gateway ? 1 : length(var.zones)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = {
    Name = "${var.environment}_NAT"
  }
}