// Declare the input variables here
// input variable
variable "environment" {
  default = "prod"
  type    = string
}

variable "region" {
  default = "ap-south-1"
  type    = string
}

variable "project_name" {
  default = "Project ALPHA Resource"
  type    = string
}

variable "default_tags" {
  default = {
    company     = "TechCorp"
    managed_by = "Terraform"
  }
}

variable "environment_tags" {
  default = {
    environment = "Development"
    cost_center = "CC1234"
  }
}

variable "allowed_ports" {
  default = "80,443,22,80,8080,3306"
}


variable "instance_sizes" {
  default = {
    dev = "t2.micro"
    prod = "t2.large"
    stage = "t2.small"
  }
}
variable "bucket_name" {
  default = "My Demo bucket for Terraform 12345"
}