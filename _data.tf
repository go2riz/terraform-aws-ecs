data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# ECS optimized AMI (Amazon Linux 2 recommended by default)
data "aws_ssm_parameter" "ecs_ami" {
  name = var.ami_ssm_parameter
}

# KMS key for default EBS encryption
# (alias/aws/ebs is AWS-managed and present in all regions)
data "aws_kms_key" "ebs" {
  key_id = "alias/aws/ebs"
}
