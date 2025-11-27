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
  region = "ap-south-1"
}


# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "main_vpc"
    Environment = "Dev"
  }
}

# create a s3 bucket
#Implicit dependency: Uses random_id resource to create unique bucket name

resource "aws_s3_bucket" "bucket1" {
  bucket = "bucket12345-${aws_vpc.main_vpc.id}" //implicit dependency

  tags = {
    Name        = "bucket1"
    VpcLinkedTo = aws_vpc.main_vpc.id
  }
}


output "resource_ids" {
  value = {
    vpc_id       = aws_vpc.main_vpc.id
    s3_bucket_id = aws_s3_bucket.bucket1.id
  }
}