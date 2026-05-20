terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*24.04*amd64*"]
  }
}

data "aws_availability_zones" "main" {
  state = "available"
}

resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc1_cidr

  tags = {
    Name = "vpc1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-igw"
  }
}

resource "null_resource" "generate_inventory" {
  triggers = {
    ec2_public_28 = "*"
  }

  provisioner "local-exec" {
    command = "~/cloud-gitlab/scripts/generate_inventory.sh"
  }
}