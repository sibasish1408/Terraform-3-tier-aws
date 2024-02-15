resource "aws_security_group" "ecs" {
  vpc_id = module.vpc_id
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

resource "aws_security_group" "elb" {
  vpc_id = module.vpc_id
  name   = "elb-sg"

  tags = {
    Name = "elb-sg"
  }
}

resource "aws_security_group_rule" "elb_ingress" {
  security_group_id = aws_security_group.elb.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs.id
}

output "elb_security_group_id" {
  value = aws_security_group.elb.id
}
