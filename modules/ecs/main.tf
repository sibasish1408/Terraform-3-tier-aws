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
    log_configuration = {
      log_driver = "awslogs"
      options = {
        "awslogs-group"  = var.log_group_name
        "awslogs-region" = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
  
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn      = var.execution_role_arn
}

resource "aws_ecs_service" "main" {
  name            = var.service_name
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = module.private_subnet_ids
    assign_public_ip = "ENABLED"
    security_groups  = module.ecs_security_group_id
  }

  load_balancer {
    target_group_arn = module.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}