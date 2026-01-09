resource "aws_security_group" "alb" {
  count = var.alb ? 1 : 0

  name        = "ecs-${var.name}-lb"
  description = "SG for ECS ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs-${var.name}-lb"
  }
}

resource "aws_security_group_rule" "alb_ingress_https" {
  count = var.alb ? 1 : 0

  description       = "HTTPS from internet"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb[0].id
}

resource "aws_security_group_rule" "alb_ingress_http" {
  count = var.alb ? 1 : 0

  description       = "HTTP from internet"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb[0].id
}

resource "aws_security_group_rule" "alb_egress_to_nodes" {
  count = var.alb ? 1 : 0

  description              = "ALB to ECS nodes"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.alb[0].id
  source_security_group_id = aws_security_group.ecs_nodes.id
}
