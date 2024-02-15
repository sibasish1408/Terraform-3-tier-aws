resource "aws_lb_target_group" "main" {
  name     = var.name
  port     = var.port
  protocol = "HTTP"
  vpc_id   = module.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.main.arn
}
