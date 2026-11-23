variable "private_subnet_ids" {
  type = list(string)
}

variable "private_instances_launch_template_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}