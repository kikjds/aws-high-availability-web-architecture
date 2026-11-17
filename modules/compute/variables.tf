variable "public_subnet_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "bastion_allowed_ip" {
  type = string
}

variable "ami_type" {
  type = string
}

variable "instance_type" {
  type = string
}