resource "aws_subnet" "subnet_public" {
  vpc_id                                      = aws_vpc.vpc1.id
  cidr_block                                  = var.subnet_public_cidr
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_default_route_table" "default_route" {
  default_route_table_id = aws_vpc.vpc1.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_default_route_table.default_route.id
}

resource "aws_security_group" "ssh_in_all_out" {
  name        = "ssh_in_all_out"
  description = "allow ssh, allow outbound all"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_public_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "eip1" {
  instance   = aws_instance.ec2_public_28.id
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "Public eip"
  }
}