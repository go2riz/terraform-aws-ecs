resource "aws_security_group" "ecs_nodes" {
  name        = "ecs-${var.name}-nodes"
  description = "SG for ECS nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ecs-${var.name}-nodes"
  }
}

resource "aws_security_group_rule" "nodes_ingress_from_alb" {
  count = var.alb ? 1 : 0

  description              = "ALB to nodes"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.ecs_nodes.id
  source_security_group_id = aws_security_group.alb[0].id
}

resource "aws_security_group_rule" "nodes_egress_all" {
  description       = "Nodes egress"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_nodes.id
}
