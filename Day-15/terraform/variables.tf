// Declare the input variables here
// input variable
variable "environment" {
  default = "prodduction"
  type    = string
}

variable "primary" {
  description = "The AWS region to create resources in."
  default     = "ap-south-1"
  type        = string
}

variable "project_name" {
  default = "Deployment-Project"
  type    = string
}

variable "secondary" {
  description = "The AWS region to create resources in."
  default     = "ap-southeast-1"
  type        = string

}


variable "tags" {
  type = map(string)
  default = {
    "environment" = "development"
    "owner"       = "team-alpha"
    "project"     = "Project ALPHA"
  }
}

variable "primary_vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "secondary_vpc_cidr" {
  default = "10.1.0.0/16"
  type    = string
}

variable "primary_subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR for the primary subnet"
}

variable "secondary_subnet_cidr" {
  type        = string
  default     = "10.1.1.0/24"
  description = "CIDR for the secondary subnet"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "primary_key_name" {
  description = "Name of the SSH key pair for Primary VPC instance (us-east-1)"
  type        = string
  default     = ""
}

variable "secondary_key_name" {
  description = "Name of the SSH key pair for Secondary VPC instance (us-west-2)"
  type        = string
  default     = ""
}