variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "elb_name" {
  description = "Name for Elastic Load Balancer"
  default     = "my-elb"
}

variable "elb_security_group_id" {
  type = string
}

