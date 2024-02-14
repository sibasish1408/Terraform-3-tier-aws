resource "aws_security_group" "ecs" {
  vpc_id = var.vpc_id
  name   = "ecs-sg"

  tags = {
    Name = "ecs-sg"
  }
}

resource "aws_security_group_rule" "ecs_ingress" {
  security_group_id = aws_security_group.ecs.id
  type              = "ingress"
  from_port         = 0
  to_port           = 5001
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "elb_ingress" {
  security_group_id = var.elb_security_group_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
