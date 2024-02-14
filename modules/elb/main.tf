resource "aws_lb" "main" {
  name               = var.elb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.vpc_id]
  security_groups    = [var.elb_security_group_id]

  enable_deletion_protection = false

  tags = {
    Name = var.elb_name
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.elb_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }

  depends_on = [aws_lb.main]
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

output "elb_name" {
  value = aws_lb.main.name
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}
