output "Gitlab" {
  value     = aws_eip.eip1.public_ip
  sensitive = true
}