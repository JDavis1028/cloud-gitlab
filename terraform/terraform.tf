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

resource "null_resource" "generate_inventory" {
  triggers = {
    ec2_public_28 = "*"
  }

  provisioner "local-exec" {
    command = "${path.module}/generate_inventory.sh"
  }
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