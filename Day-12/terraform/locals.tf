locals {
  // assignment 1: formatting project name
  formatted_project_name = lower(replace(var.project_name," ", "-")) 
  
  // assignment 2: Resource tagging
  formatted_tags = merge(var.default_tags, var.environment_tags) // Merging default and environment-specific tags

  // assignment 3: S3 Bucket Naming
  bucket_name = lower(replace(substr(var.bucket_name, 0, 63)," ","-"))
  

  //assignment 4: Security Group Rules from Ports
  port_list = split(",", var.allowed_ports) // Converting comma-separated string to list
  sg_rules = [
    for port in local.port_list : {
      name = "port-${port}-rule"
      port = port
      description = "Allow inbound traffic on port ${port}"
    }
   
  ]
   port_string = join(" | ",local.port_list)


   
  //assignment 5: Instance Size Selection
  instance_size = lookup(var.instance_sizes,  var.environment, "dev") // Selecting instance size based on environment



  // Day-12
  //Assignment 9: Location Management
  all_locations = concat(var.user_locations,var.default_location)
  unique_locations = toset(local.all_locations)

  //Assignment 10: Cost Calculation
  positive_cost = [for cost in var.monthly_costs : abs(cost)]
  max_cost = max(local.positive_cost...)
  min_cost = min(local.positive_cost...)
  total_cost = sum(local.positive_cost)
  avg_cost = local.total_cost / length(local.positive_cost)

  current_timestamp = timestamp()
  format1 = formatdate("DD-MM-YYYY", local.current_timestamp)
  format2 = formatdate("YYYY/MM/DD HH:MM:SS", local.current_timestamp)
  timestamp_name = "backup-${local.format1}"


  //Assignment 8: File Path Processing
  dir_name = dirname("./config.json")
  config_file_exists = fileexists("${local.dir_name}/config.json")
  config_file_data =  local.config_file_exists ? jsondecode(file("./config.json")) : null
}
