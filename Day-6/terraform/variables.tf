// Declare the input variables here
// input variable
variable "environment" {
  default = "dev"
  type    = string
}

// local variables
locals {
  bucket_name = "bucket-${var.environment}-"
  vpc_name    = "${var.environment}-vpc"
}

variable "region" {
  default = "ap-south-1"
  type    = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}