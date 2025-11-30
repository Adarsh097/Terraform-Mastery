// Define the information to be outputted after terraform apply

# output "resource_ids" {
#   value = {
#     environment    = var.environment
#     region         = var.region
#     ec2_name       = aws_instance.ec2.tags["Name"]
#     ec2_id         = aws_instance.ec2.id
#   }
# }


output "deployment_summary"{
    value = {
        environment = var.environment
        region      = var.region
        instance_count = var.instance_count
        s3_bucket_name_tage = var.s3_bucket_config.tag_name
    }
}