locals {
  ecs_ami_id = coalesce(var.ami_id, data.aws_ssm_parameter.ecs_ami.value)

  userdata_rendered = templatefile("${path.module}/userdata.tpl", {
    tf_cluster_name = aws_ecs_cluster.ecs.name
    tf_efs_id       = aws_efs_file_system.ecs.id
    userdata_extra  = var.userdata
  })

  instance_security_group_ids = distinct(concat([aws_security_group.ecs_nodes.id], var.security_group_ids))
}

resource "aws_launch_template" "ecs" {
  name_prefix   = "ecs-${var.name}-"
  image_id      = local.ecs_ami_id
  instance_type = var.instance_type_1

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs.name
  }

  vpc_security_group_ids = local.instance_security_group_ids

  user_data = base64encode(local.userdata_rendered)

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = var.imds_http_tokens
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      encrypted   = true
      kms_key_id  = data.aws_kms_key.ebs.arn
      volume_size = var.root_volume_size
      volume_type = var.root_volume_type
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
