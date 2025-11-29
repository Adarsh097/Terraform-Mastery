// All resources defined in main.tf

# Create a VPC
resource "aws_vpc" "main_vpc" {
  region     = var.region
  cidr_block = var.vpc_cidr

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
  ami           = "ami-087d1c9a513324697"
  instance_type = "t2.micro"
  region        = var.region

  tags = {
    Name        = "${var.environment}-ec2-instance"
    Environment = var.environment
  }


}
