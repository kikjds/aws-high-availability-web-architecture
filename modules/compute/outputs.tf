output "bastion_instance_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_instances_launch_template_id" {
  value = aws_launch_template.private_instances_template.id
}