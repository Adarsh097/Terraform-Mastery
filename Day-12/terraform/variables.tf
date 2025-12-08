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
    company    = "TechCorp"
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
    dev   = "t2.micro"
    prod  = "t2.large"
    stage = "t2.small"
  }
}
variable "bucket_name" {
  default = "My Demo bucket for Terraform 12345"
}

// DAY-12

//Assignment 6: Instance Validation
variable "instance_type" {
  default = "t2.micro"
  validation {
    condition     = length(var.instance_type) >= 2 && length(var.instance_type) <= 20
    error_message = "Instance type must be 2 and 20 characters."
  }
  validation {
    condition     = can(regex("^t[2-3]\\.", var.instance_type))
    error_message = "Instance type must start with t2. or t3."
  }
}

//Assignment 7: Backup Configuration
variable "backup_name" {
  default = "daily_backup"

  validation {
    condition     = endswith(var.backup_name, "_backup")
    error_message = "Backup name must end with '_backup'"
  }
}

// Assignment 7: Backup Configuration
variable "credentials" {
  default   = "xyzabc123"
  sensitive = true
}

variable "user_locations" {
  default = ["us-west-1", "us-east-1", "eu-central-1", "ap-south-1"]
}

variable "default_location" {
  default = ["ap-south-1"]
}

variable "monthly_costs" {
  default = [-50, 100, 150, 200, 250] # negative value indicates refunds
}