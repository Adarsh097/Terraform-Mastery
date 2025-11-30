// All resources defined in main.tf




resource "aws_instance" "ec2" {
  count = var.instance_count
  ami           = "ami-087d1c9a513324697"
  instance_type = var.allowed_vms[0]
  region        = tolist(var.allowed_regions)[0]//convert set to list and access first element
  monitoring = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name        = "${var.environment}-ec2-instance"
    Environment = var.environment
  }


}

# Security Group for EC2
resource "aws_security_group" "web_sg" {
  # String type: Name and description
  name        = "${var.security_group_config.name}-sg"  # Object type usage
  description = var.security_group_config.description
  
  # HTTP access using tuple type (port number from network_config[2])
  ingress {
    from_port   = var.network_config[1]  # Tuple type: third element (number)
    to_port     = var.network_config[1]  # Tuple type: third element (number)
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks # List type
  }
  
  # SSH access  
  ingress {
    from_port   = var.network_config[3]  # Tuple type: fourth element (number)
    to_port     = var.network_config[3]  # Tuple type: fourth element (number)
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # List type
  }
  
  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Map type: Tags
  tags = var.instance_tags
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "${var.environment}${var.s3_bucket_config.bucket_prefix}-bucket"  //using object type variable
  tags = {
    Name = var.s3_bucket_config.tag_name
    Environment = var.environment

  }
}