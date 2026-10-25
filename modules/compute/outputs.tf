output "bastion_instance_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_instances_private_ip" {
  value = aws_instance.private_instances[*].private_ip
}