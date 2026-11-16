variable "aws_region" {
  type        = string
  description = "AWS region where resources will be created"
}

variable "resource_tags" {
  type        = map(string)
  description = "Common tags applied to every AWS resource that supports tags"
  nullable    = false

  validation {
    condition = alltrue([
      for required_tag in ["Project", "Environment", "ManagedBy"] :
      contains(keys(var.resource_tags), required_tag)
    ])
    error_message = "resource_tags must include Project, Environment, and ManagedBy."
  }
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

variable "allowed_principal_arns" {
  type        = list(string)
  description = "Allowed IAM principal ARNs"
}

variable "ssh_key_name" {
  type = string
  description = "SSH key name to attach with vms"
}

variable "ami_type" {
  type = string
  description = "AMI type for instances"
}

variable "instance_type" {
  type = string
  description = "Instance type"
}