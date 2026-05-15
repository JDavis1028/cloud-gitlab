resource "aws_instance" "ec2_public_28" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name      = var.key_pair_name

  network_interface {
    network_interface_id = aws_network_interface.ec2_pub_28_netint.id
    device_index         = 0
  }

  tags = {
    Name = "public_28"
  }
}

resource "aws_network_interface" "ec2_pub_28_netint" {
  subnet_id       = aws_subnet.subnet_public.id
  private_ips     = [var.pub28_priv_ip]
  security_groups = [aws_security_group.ssh_in_all_out.id]

  tags = {
    Name = "ec2_public_28_network_interface"
  }
}