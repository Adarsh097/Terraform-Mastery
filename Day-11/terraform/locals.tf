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
}
