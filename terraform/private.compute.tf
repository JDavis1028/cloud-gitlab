#resource "aws_instance" "ec2_private_28" {
#  ami           = data.aws_ami.ubuntu.id
#  instance_type = "t3.micro"
#
#  network_interface {
#    network_interface_id = aws_network_interface.ec2_priv_28_netint.id
#    device_index         = 0
#  }
#
#  tags = {
#    Name = "private_28"
#  }
#} 

resource "aws_db_instance" "gitlab_rds" {
  db_name = "gitlab_database"
  engine = "postgres"
  instance_class = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.gl_subnet.id
  username = var.gl_db_username
  password = var.gl_db_passwd

  allocated_storage = 20
  storage_encrypted = true
  multi_az = false
  skip_final_snapshot = true
} 

resource "aws_network_interface" "ec2_priv_28_netint" {
  subnet_id       = aws_subnet.subnet_private1.id
  private_ips     = [var.priv28_priv_ip]
  security_groups = [aws_security_group.fe_in_all_out.id]

  tags = {
    Name = "ec2_private_28_network_interface"
  }
}