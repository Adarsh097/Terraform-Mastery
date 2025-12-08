
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
  value = local.instance_size
}

// assignment 2: Resource tagging
output "formatted_tags" {
  value = local.formatted_tags
}

// assignment 3: S3 Bucket Naming
output "bucket" {
  value = aws_s3_bucket.bucket2
}


// Day-12

output "credentials" {
  value     = var.credentials
  sensitive = true
}

output "all_locations" {
  value = local.all_locations
}

output "unique_locations" {
  value = local.unique_locations
}

output "positive_cost" {
  value = local.positive_cost
}

output "max_cost" {
  value = local.max_cost
}

output "min_cost" {
  value = local.min_cost
}

output "total_cost" {
  value = local.total_cost
}

output "avg_cost" {
  value = local.avg_cost
}

output "time_formats" {
  value = {
    current_timestamp = local.current_timestamp
    format1           = local.format1
    format2           = local.format2
    timestamp_name    = local.timestamp_name
  }
}


output "config" {
  value = {
    dir_name             = local.dir_name
    config_file_exists   = local.config_file_exists
    config_file_data     = local.config_file_data
  }
}