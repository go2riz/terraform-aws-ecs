# == REQUIRED VARS

variable "name" {
  description = "Name of this ECS cluster"
  type        = string
}

variable "instance_type_1" {
  description = "Instance type for ECS workers (first priority)"
  type        = string
}

variable "instance_type_2" {
  description = "Instance type for ECS workers (second priority)"
  type        = string
}

variable "instance_type_3" {
  description = "Instance type for ECS workers (third priority)"
  type        = string
}

variable "on_demand_percentage" {
  description = "Percentage of on-demand instances vs spot"
  type        = number
  default     = 100
}

variable "vpc_id" {
  description = "VPC ID to deploy the ECS cluster"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS instances"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ECS ALB"
  type        = list(string)
}

variable "secure_subnet_ids" {
  description = "List of secure subnet IDs for EFS"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ACM certificate ARN used for the ALB HTTPS listener"
  type        = string
}

# == OPTIONAL VARS

variable "security_group_ids" {
  description = "Extra security groups for instances"
  type        = list(string)
  default     = []
}

variable "userdata" {
  description = "Extra commands to append to instance user-data"
  type        = string
  default     = ""
}

variable "alb" {
  description = "Whether to deploy an ALB with the cluster"
  type        = bool
  default     = true
}

variable "asg_min" {
  type    = number
  default = 1
}

variable "asg_max" {
  type    = number
  default = 4
}

variable "asg_memory_target" {
  type    = number
  default = 60
}

# == AMI / INSTANCE HARDENING

variable "ami_id" {
  description = "Override AMI ID for ECS instances (optional). If null, uses the SSM parameter below."
  type        = string
  default     = null
}

variable "ami_ssm_parameter" {
  description = "SSM Parameter name for ECS optimized AMI (Amazon Linux 2 recommended by default)."
  type        = string
  default     = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

variable "root_volume_size" {
  description = "Root EBS volume size (GiB)."
  type        = number
  default     = 30
}

variable "root_volume_type" {
  description = "Root EBS volume type."
  type        = string
  default     = "gp3"
}

variable "imds_http_tokens" {
  description = "Instance Metadata Service (IMDS) token requirement. Use 'required' to enforce IMDSv2."
  type        = string
  default     = "required"

  validation {
    condition     = contains(["optional", "required"], var.imds_http_tokens)
    error_message = "imds_http_tokens must be either 'optional' or 'required'."
  }
}
