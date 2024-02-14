resource "aws_lb_target_group" "main" {
  name     = "${var.service_name}-target-group"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path     = "/"
    protocol = "HTTP"
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.task_family
  container_definitions    = jsonencode([{
    name      = var.container_name
    image     = var.container_image
    cpu       = var.container_cpu
    memory    = var.container_memory
    portMappings = [
      {
        containerPort = var.container_port
        hostPort      = var.container_port
        protocol      = "tcp"
      }
    ]
    log_configuration {
      log_driver = "awslogs"
      options = {
        "awslogs-group"  = var.log_group_name
        "awslogs-region" = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "main" {
  name            = var.service_name
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [var.vpc_id]
    assign_public_ip = "ENABLED"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_lb_target_group_attachment" "ecs_service" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_ecs_service.main.id
}
