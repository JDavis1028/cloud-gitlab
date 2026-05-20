resource "aws_instance" "GitLab" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t3a.medium"
  key_name          = var.key_pair_name
  availability_zone = "us-east-2a"

  network_interface {
    network_interface_id = aws_network_interface.gitlab_netint.id
    device_index         = 0
  }

  tags = {
    Name = "GitLab"
  }
}

resource "aws_volume_attachment" "gitlab_ebs_att" {
  device_name = "/dev/sdd"
  volume_id   = aws_ebs_volume.gitlab_ebs.id
  instance_id = aws_instance.GitLab.id
}

resource "aws_ebs_volume" "gitlab_ebs" {
  availability_zone = "us-east-2a"
  size              = "30"
}

resource "aws_network_interface" "gitlab_netint" {
  subnet_id       = aws_subnet.subnet_public.id
  private_ips     = [var.gitlab_frontend_priv_ip]
  security_groups = [aws_security_group.ssh_in_all_out.id]

  tags = {
    Name = "GitLab_netint"
  }
}

# GitLab database inside of a private subnet

resource "aws_db_instance" "gitlab_rds" {
  db_name              = "gitlab_database"
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.gl_subnet.id
  username             = var.gl_db_username
  password             = var.gl_db_passwd

  allocated_storage   = 20
  storage_encrypted   = true
  multi_az            = true
  skip_final_snapshot = true

  tags = {
    Name = "Gitlab_database"
  }
} 