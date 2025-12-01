// Declare the input variables here
// input variable
variable "environment" {
  default = "dev"
  type    = string
}
variable "s3_bucket_config" {
  type = object({
    bucket_prefix = string
    tag_name      = string
  })
}

// local variables
locals {
  bucket_name = "bucket-${var.environment}-"
  vpc_name    = "${var.environment}-vpc"
}

// STRING
variable "region" {
  description = "region where the resource will be created."
  default     = "ap-south-1"
  type        = string
}


// SET
variable "allowed_regions" {
  description = "List of allowed AWS region"
  type        = set(string)
  default     = ["ap-south-1", "us-east-1", "us-east-2"]
}

// NUMBER
variable "instance_count" {
  description = "Number of EC2 instances to create."
  type        = number
  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "Instance count must be between 1 and 10"
  }
}

// BOOLEAN
variable "monitoring" {
  type    = bool
  default = true
}

// BOOLEAN
variable "associate_public_ip_address" {
  type    = bool
  default = true
}

// OBJECT
variable "security_group_config" {
  type = object({
    name        = string
    description = string
  })
}


// TUPLE
variable "network_config" {

  type = tuple([number, number, number, number])
}

// LIST
variable "allowed_cidr_blocks" {
  description = "CIDR block for VPC"
  type        = list(string)
}

// MAP
variable "instance_tags" {
  type = map(string)
}


// LIST
variable "allowed_vms" {
  type    = list(string)
  default = ["t2.micro", "t3.micro", "t2.small"]
}


//Day-8 

variable "bucket_names" {
  description = "List of S3 bucket names"
  type        = list(string)
  default     = ["bucket-one-day-8-12345", "bucket-two-day-8-12345", "bucket-three-day-8-12345"]

}

variable "bucket_names_set" {
  description = "List of s3 bucket names"
  type = set(string)
  default = ["bucket-one-day-8-12345", "bucket-two-day-8-12345", "bucket-three-day-8-12345"]  
}