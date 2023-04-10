#____________________________________________Public_subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.zones)
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index * 2)
  availability_zone = element(var.zones, count.index)

  tags = {
    Name = "${var.environment}_Public_Subnet"
  }
}

#____________________________________________Private_subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.zones)
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index * 2 + 1)
  availability_zone = element(var.zones, count.index)

  tags = {
    Name = "${var.environment}_Private_Subnet"
  }
}