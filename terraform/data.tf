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

#data "aws_rds_orderable_db_instance" "gitlab_rds" {
#  engine = "postgres"
#  engine_latest_version = true
#}