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


variable "tags" {
  type = map(string)
  default = {
    "environment" = "development"
    "owner"       = "team-alpha"
    "project"     = "Project ALPHA"
  }
}