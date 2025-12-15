// Declare the input variables here
// input variable
variable "environment" {
  default = "prodduction"
  type    = string
}

variable "region" {
  description = "The AWS region to create resources in."
  default     = "ap-south-1"
  type        = string
}

variable "project_name" {
  default = "Deployment-Project"
  type    = string
}



variable "tags" {
  type = map(string)
  default = {
    "environment" = "development"
    "owner"       = "team-alpha"
    "project"     = "Project ALPHA"
  }
}

