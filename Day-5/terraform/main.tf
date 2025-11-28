// input variable
variable "environment" {
  default = "dev"   
  type = string
}

// local variables
locals {
  bucket_name = "bucket-${var.environment}-"
  vpc_name = "${var.environment}-vpc"
}

variable "region" {
  default = "ap-south-1"
  type    = string
}


terraform {
// Configure the S3 backend to store the Terraform state file
  backend "s3" {
    bucket       = "adarsh-s3-statefile-bucket-1"
    key          = "dev/terraform.tfstate" // path within the bucket
    region       = "ap-south-1"
    encrypt      = true // to enable server-side encryption
    use_lockfile = true // to prevent concurrent modifications using S3 object locking
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" // will upgrade to latest 6.x version and not 7.x
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


# Create a VPC
resource "aws_vpc" "main_vpc" {
  region = var.region
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = local.vpc_name
    Environment = var.environment
  }
}

# create a s3 bucket
#Implicit dependency: Uses random_id resource to create unique bucket name

resource "aws_s3_bucket" "bucket1" {
  bucket = "${local.bucket_name}${aws_vpc.main_vpc.id}" //implicit dependency

  tags = {
    Name        = "${var.environment}-s3-bucket"
    VpcLinkedTo = aws_vpc.main_vpc.id
    Environment = var.environment
  }
}



resource "aws_instance" "ec2" {
  ami = "ami-087d1c9a513324697"
  instance_type = "t2.micro"
  region = var.region

  tags = {
    Name = "${var.environment}-ec2-instance"
    Environment = var.environment
  }


}


// Output variables
output "resource_ids" {
  value = {
    vpc_id       = aws_vpc.main_vpc.id
    s3_bucket_id = aws_s3_bucket.bucket1.id
    ec2_id       = aws_instance.ec2.id
  }
}