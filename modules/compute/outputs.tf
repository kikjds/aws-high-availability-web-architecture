output "bastion_instance_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_instances_private_ips" {
  value = aws_instance.private_instances[*].private_ip
}

output "private_instance_ids" {
  value = aws_instance.private_instances[*].id
}