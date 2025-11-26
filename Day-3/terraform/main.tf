terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" // will upgrade to latest 6.x version and not 7.x
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# getting unique id for the bucket name
resource "random_id" "suffix" {
  byte_length = 4
}

# create a s3 bucket

resource "aws_s3_bucket" "bucket1" {
  bucket = "bucket1-${random_id.suffix.hex}"

  tags = {
    Name = "My bucket 2.0"
    Environment = "Dev"
  }
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
    Environment = "Dev"
  }
}

# create a s3 bucket
#Implicit dependency: Uses random_id resource to create unique bucket name

resource "aws_s3_bucket" "bucket2" {
  bucket = "bucket12345-${aws_vpc.main_vpc.id}" //implicit dependency

  tags = {
    Name = "bucket2"
    VpcLinkedTo = aws_vpc.main_vpc.id
  }
}

output "resource_ids" {
  value = {
    vpc_id        = aws_vpc.main_vpc.id
    s3_bucket_id  = aws_s3_bucket.bucket2.id
  }
}