resource "aws_instance" "ec2-first" {
  ami = "ami-087d1c9a513324697"
  instance_type = var.allowed_vms[0]
  region = "ap-south-1"

  tags = var.instance_tags

  lifecycle {
    create_before_destroy = true //recreate instance before destroying the old one
    # prevent_destroy =  true //prevent accidental deletion
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

resource "aws_instance" "ec2-second" {
  ami = "ami-087d1c9a513324697"
  instance_type = var.allowed_vms[1]
  region = tolist(var.allowed_regions)[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = var.instance_tags

  lifecycle {
    //if we make any changes to security group, recreate the instance
    replace_triggered_by = [aws_security_group.web_sg.id
     ]
  }
  
}


resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "compliance-bucket-1234-s3tf-demo"
  region = var.region

  tags = {
    Environment = "production"
    Compliance  = "SOC2"
  }

  lifecycle {
    precondition {
      condition = var.region == "ap-south-1"
      error_message = "ERROR: Buckets can only be created in the ap-south-1 region."
    }
    postcondition {
      condition     = contains(keys(self.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag!"
    }

    postcondition {
      condition     = contains(keys(self.tags), "Environment")
      error_message = "ERROR: Bucket must have an 'Environment' tag!"
    }
  }
}