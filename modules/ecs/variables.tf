variable "service_name" {
  description = "Name of the ECS service"
  default     = "ecs-service"
}

variable "task_family" {
  description = "Family name of the ECS task definition"
  default     = "ecs-task"
}

variable "container_name" {
  description = "Name of the ECS container"
  default     = "ecs-container"
}

variable "container_image" {
  description = "Docker image for the ECS container"
  default     = "ecr-image"
}

variable "container_cpu" {
  description = "CPU units for the ECS container"
  default     = 256
}

variable "container_memory" {
  description = "Memory limit for the ECS container (in MiB)"
  default     = 512
}

variable "container_port" {
  description = "Port number the container listens on"
  default     = 80
}

variable "log_group_name" {
  description = "Name of the CloudWatch Logs log group"
  default     = "ecs-log"
}
