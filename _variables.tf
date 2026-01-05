# == REQUIRED VARS

variable "name" {
  type        = string
  description = "Name of this ECS cluster"
}

variable "instance_type_1" {
  type        = string
  description = "Instance type for ECS workers (first priority)"
}

variable "instance_type_2" {
  type        = string
  description = "Instance type for ECS workers (second priority)"
}

variable "instance_type_3" {
  type        = string
  description = "Instance type for ECS workers (third priority)"
}

variable "on_demand_percentage" {
  type        = number
  description = "Percentage of on-demand intances vs spot"
  default     = 100
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy the ECS cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for ECS instances"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for ECS ALB"
}

variable "secure_subnet_ids" {
  type        = list(string)
  description = "List of secure subnet IDs for EFS"
}

variable "certificate_arn" {}

# == OPTIONAL VARS

variable "alb" {
  type        = bool
  default     = true
  description = "Whether to deploy an ALB or not with the cluster"
}

variable "asg_min" {
  type        = number
  default = 1
}

variable "asg_max" {
  type        = number
  default = 4
}

variable "asg_memory_target" {
  type        = number
  default = 60
}

variable "alarm_sns_topics" {
  description = "SNS topics to notify for ECS/ALB/ASG alarms (leave empty to disable alarm actions)."
  type        = list(string)
  default     = []
}
