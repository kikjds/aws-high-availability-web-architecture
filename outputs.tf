output "bastion_instance_public_ip" {
  description = "Public IP address of the bastion instance"
  value       = module.compute.bastion_instance_public_ip
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = module.alb.alb_dns_name
}