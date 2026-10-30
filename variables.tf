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

variable "dynamodb_table_name" {
  type        = string
  description = "Dynamodb table name"
}

variable "dynamodb_hash_key" {
  type        = string
  description = "Dynamodb table partition key attribute name"
}

variable "dynamodb_range_key" {
  type        = string
  description = "Dynamodb table sort key attribute name"
}