variable "vpc_id" {
  type = string
}

variable "private_instance_ids" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}