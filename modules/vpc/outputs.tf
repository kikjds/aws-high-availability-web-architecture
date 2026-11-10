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

output "public_subnets" {
  description = "Public subnets"
  value       = aws_subnet.public[*].id
}

output "private_route_table_id" {
  description = "Private route table id"
  value       = aws_route_table.private_route_table.id
}