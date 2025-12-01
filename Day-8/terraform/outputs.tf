// Define the information to be outputted after terraform apply

# output "resource_ids" {
#   value = {
#     environment    = var.environment
#     region         = var.region
#     ec2_name       = aws_instance.ec2.tags["Name"]
#     ec2_id         = aws_instance.ec2.id
#   }
# }


output "deployment_summary" {
  value = {
    environment         = var.environment
    region              = var.region
    instance_count      = var.instance_count
    s3_bucket_name_tage = var.s3_bucket_config.tag_name
  }
}

//TASK-3 outputs for bucket2 and bucket3 names and ids using for expressions

output "bucket2_names" {
  description = "List of all the bucket2 names"
  value = [for b in aws_s3_bucket.bucket2 : b.bucket]
}

output "bucket2_ids" {
  description = "List of all the bucket2 ids"
  value = [for b in aws_s3_bucket.bucket2: b.id]
}

output "bucket3_names" {
  description = "List of all the bucket3 names"
  value = [for b in aws_s3_bucket.bucket3 : b.bucket]
}

output "bucket3_ids" {
  description = "List of all the bucket3 ids"
  value = [for b in aws_s3_bucket.bucket3 : b.id]
}