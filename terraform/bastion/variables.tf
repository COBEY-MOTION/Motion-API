variable "vpc_id" {
  description = "VPC ID for the bastion host"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for deploying the bastion host"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
  default     = "ami-07d2649d67dbe8900"
}

variable "instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name to use for SSH access"
  type        = string
}
