output "bastion_instance_public_ip" {
  value = module.compute.bastion_instance_public_ip
}
output "private_instances_private_ips" {
  value = module.compute.private_instances_private_ip
}