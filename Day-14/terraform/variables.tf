// Declare the input variables here
// input variable
variable "environment" {
  default = "prodduction"
  type    = string
}

variable "aws_region" {
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

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name."
  type        = string
  default     = "my-static-website-"
}
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "bucket-7973-mumbai"
}