variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "elb_name" {
  description = "Name for Elastic Load Balancer"
  default     = "my-elb"
}