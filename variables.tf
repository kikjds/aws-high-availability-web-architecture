variable "aws_region" {
  type        = string
  description = "AWS region where resources will be created"
}

variable "vpc_cidr_range" {
  type        = string
  description = "CIDR range for the VPC"
}

variable "cidr_range_public_azs" {
  type        = list(string)
  description = "List of CIDR ranges for public subnets"
}

variable "cidr_range_private_azs" {
  type        = list(string)
  description = "List of CIDR ranges for private subnets"
}