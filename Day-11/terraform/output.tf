
output "resources" {
  value = {
    // assignment 1: formatting project name
    project_name = local.formatted_project_name

    // assignment 4: Security Group Rules from Ports
    port_list   = local.port_list
    sg_rules    = local.sg_rules
    port_string = local.port_string
  }
}

// assignment 5: Instance Size Selection
output "instance_size" {
  value =  local.instance_size
}

// assignment 2: Resource tagging
output "formatted_tags" {
  value = local.formatted_tags
}

// assignment 3: S3 Bucket Naming
output "bucket" {
  value = aws_s3_bucket.bucket2
}