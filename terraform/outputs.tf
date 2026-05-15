output "ec2_public_28" {
  value     = aws_instance.ec2_public_28.public_ip
  sensitive = true
}

#output "public_ec2_names" {
#    value = aws_instance.ec2_public_28.tags_all
#}

#output "public_ips" {
#    value = [
#        for instance in aws_instance. : {
#            id = instance.id
#            public_ip = instance.public_ip
#            private_ip = instance.private_ip
#        }
#    ]
#}
