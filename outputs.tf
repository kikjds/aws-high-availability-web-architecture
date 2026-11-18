output "bastion_instance_public_ip" {
  description = "Public IP address of the bastion instance"
  value       = module.compute.bastion_instance_public_ip
}

output "private_instances_private_ips" {
  description = "Private IP addresses of the application instances"
  value       = module.compute.private_instances_private_ips
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = module.alb.alb_dns_name
}