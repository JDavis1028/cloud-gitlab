resource "aws_subnet" "subnet_private1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"
  # availability_zone_id = data.aws_availability_zones.main.names[0]
  availability_zone = "us-east-2a"

  tags = {
    Name = "Private subnet1"
  }
}

resource "aws_subnet" "subnet_private2" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.3.0/24"
  # availability_zone_id = data.aws_availability_zones.main.names[1]
  availability_zone = "us-east-2b"

  tags = {
    Name = "Private subnet2"
  }
}

resource "aws_db_subnet_group" "gl_subnet" {
  name       = "gl_db_subnet"
  subnet_ids = [aws_subnet.subnet_private1.id, aws_subnet.subnet_private2.id]
}

resource "aws_security_group" "fe_in_all_out" {
  name        = "FE_in_all_out"
  description = "Front end in all traffic out"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}