output "public_subnet_id" {
  description = "Public subnet id"
  value       = aws_subnet.public[1].id
}

output "private_subnet_ids" {
  description = "Private subnet ids"
  value       = aws_subnet.private[*].id
}

output "vpc_id" {
  description = "Vpc id"
  value       = aws_vpc.main.id
}