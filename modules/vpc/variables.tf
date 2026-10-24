variable "cidr_range" {
  type = string
}

variable "cidr_range_public_azs" {
  type = list(string)
}

variable "cidr_range_private_azs" {
  type = list(string)
}