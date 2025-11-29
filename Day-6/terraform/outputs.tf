// Define the information to be outputted after terraform apply

output "resource_ids" {
  value = {
    environment    = var.environment
    region         = var.region
    vpc_id         = aws_vpc.main_vpc.id
    s3_bucket_name = aws_s3_bucket.bucket1.bucket
    s3_bucket_id   = aws_s3_bucket.bucket1.id
    ec2_name       = aws_instance.ec2.tags["Name"]
    ec2_id         = aws_instance.ec2.id
  }
}