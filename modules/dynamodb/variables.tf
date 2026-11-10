variable "dynamodb_table_name" {
  type = string
}

variable "dynamodb_hash_key" {
  type = string
}

variable "dynamodb_range_key" {
  type = string
}

variable "vpc_endpoint_id" {
  type = string
}

variable "allowed_principal_arns" {
  type = list(string)
}