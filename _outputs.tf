output "alb_id" {
  value       = aws_lb.ecs[*].id
  description = "ALB IDs (empty if alb=false)"
}

output "alb_arn" {
  value       = aws_lb.ecs[*].arn
  description = "ALB ARNs (empty if alb=false)"
}

output "alb_dns_name" {
  value       = aws_lb.ecs[*].dns_name
  description = "ALB DNS names (empty if alb=false)"
}

output "alb_zone_id" {
  value       = aws_lb.ecs[*].zone_id
  description = "ALB hosted zone IDs (empty if alb=false)"
}

output "ecs_iam_role_arn" {
  value       = aws_iam_role.ecs.arn
  description = "EC2 instance IAM role ARN"
}

output "ecs_iam_role_name" {
  value       = aws_iam_role.ecs.name
  description = "EC2 instance IAM role name"
}

output "ecs_service_iam_role_arn" {
  value       = aws_iam_role.ecs_service.arn
  description = "ECS service IAM role ARN"
}

output "ecs_service_iam_role_name" {
  value       = aws_iam_role.ecs_service.name
  description = "ECS service IAM role name"
}

output "ecs_task_iam_role_arn" {
  value       = aws_iam_role.ecs_task.arn
  description = "ECS task IAM role ARN"
}

output "ecs_task_iam_role_name" {
  value       = aws_iam_role.ecs_task.name
  description = "ECS task IAM role name"
}

output "ecs_id" {
  value       = aws_ecs_cluster.ecs.id
  description = "ECS cluster ID"
}

output "ecs_arn" {
  value       = aws_ecs_cluster.ecs.arn
  description = "ECS cluster ARN"
}

output "ecs_name" {
  value       = aws_ecs_cluster.ecs.name
  description = "ECS cluster name"
}

output "alb_listener_https_arn" {
  value       = aws_lb_listener.ecs_https[*].arn
  description = "HTTPS listener ARNs (empty if alb=false)"
}

output "ecs_nodes_secgrp_id" {
  value       = aws_security_group.ecs_nodes.id
  description = "Security group ID for ECS nodes"
}
