#____________________________________________My_IP
#data "http" "my_ip" {
#  url = "http://ipv4.icanhazip.com"
#}

#____________________________________________Public_security_groups
resource "aws_security_group" "public" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] #["${chomp(data.http.my_ip.response_body)}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.vpc_cidr]
  }
  dynamic "egress" {
    for_each = [var.my_ip] #["${chomp(data.http.my_ip.response_body)}/32"]
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [egress.value]
    }
  }
  dynamic "egress" {
    for_each = ["53", "443"]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "${var.environment}_Public_Security_Group"
  }
}

#____________________________________________Private_security_groups
resource "aws_security_group" "private" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["22", "80", "8080", "443", "3000", "9090", "9100"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.vpc_cidr]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }
  dynamic "egress" {
    for_each = ["53", "80", "443", "3000", "9090", "9100"]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "${var.environment}_Private_Security_Group"
  }
}

#____________________________________________RDS_security_groups
resource "aws_security_group" "sg_rds" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  tags = {
    Name = "${var.environment}_RDS_Security_Group"
  }
}

#______________________________Security_group_for_ALB_public
resource "aws_security_group" "sg_https" {
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["443", "80", "9100"]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.environment}_Public_Security_group_for_ALB"
  }
}