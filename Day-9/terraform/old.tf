# // All resources defined in main.tf




# resource "aws_instance" "ec2" {
#   count = var.instance_count
#   ami           = "ami-087d1c9a513324697"
#   instance_type = var.allowed_vms[0]
#   region        = tolist(var.allowed_regions)[0]//convert set to list and access first element
#   monitoring = var.monitoring
#   associate_public_ip_address = var.associate_public_ip_address

#   tags = {
#     Name        = "${var.environment}-ec2-instance"
#     Environment = var.environment
#   }


# }

# # Security Group for EC2
# resource "aws_security_group" "web_sg" {
#   # String type: Name and description
#   name        = "${var.security_group_config.name}-sg"  # Object type usage
#   description = var.security_group_config.description
  
#   # HTTP access using tuple type (port number from network_config[2])
#   ingress {
#     from_port   = var.network_config[1]  # Tuple type: third element (number)
#     to_port     = var.network_config[1]  # Tuple type: third element (number)
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_cidr_blocks # List type
#   }
  
#   # SSH access  
#   ingress {
#     from_port   = var.network_config[3]  # Tuple type: fourth element (number)
#     to_port     = var.network_config[3]  # Tuple type: fourth element (number)
#     protocol    = "tcp"
#     cidr_blocks = var.allowed_cidr_blocks  # List type
#   }
  
#   # Outbound traffic
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Map type: Tags
#   tags = var.instance_tags
# }

# resource "aws_s3_bucket" "bucket1" {
#   bucket = "${var.environment}${var.s3_bucket_config.bucket_prefix}-bucket"  //using object type variable

#   tags = {
#     Name = var.s3_bucket_config.tag_name
#     Environment = var.environment
#     created_by = "terraform"

#   }
# }

# // TASK-1 -> Create multiple S3 buckets using count and list variable
# resource "aws_s3_bucket" "bucket2" {
#   count = length(var.bucket_names)  // length function to get number of elements in list
#   bucket = "${var.environment}-${var.bucket_names[count.index]}"  // index will start form 0
#   depends_on = [ aws_s3_bucket.bucket1 ] // to ensure bucket1 is created first
#   tags = {
#     Name = var.bucket_names[count.index]
#     Environment = var.environment
#     created_by = "terraform"
#   }
# }

# // TASK-2 -> Create multiple S3 buckets using for_each and set variable
# resource "aws_s3_bucket" "bucket3" {
  
#   for_each = var.bucket_names_set
#   bucket   = "3-${var.environment}-${each.value}"  // each.value will give the actual value from set
#   depends_on = [ aws_s3_bucket.bucket1,aws_s3_bucket.bucket2 ]// to ensure bucket1 and bucket2 are created first

#   tags = {
#     Name = each.key // or each.value
#     Environment = var.environment
#     created_by = "terraform-set"
#   }
  
# }