
// data source for VPC to get VPC ID based on Name tag
data "aws_vpc" "vpc_name" {
  filter {
    name   = "tag:Name"
    values = ["default-vpc"]
  }
}

// data source for Subnet to get Subnet ID based on Name tag in the VPC that we fetched above
data "aws_subnet" "shared_subnet" {
  filter {
    name   = "tag:Name"
    values = ["subnet-a"]
  }
  vpc_id = data.aws_vpc.vpc_name.id
}


data "aws_ami" "linux2" {
  most_recent = true       // Fetch the most recent AMI
  owners      = ["amazon"] // Owner ID for Amazon Linux AMIs
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] // Pattern to match Amazon Linux 2 AMIs
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] // Ensuring we get HVM virtualization type
  }
  filter {
    name   = "architecture"
    values = ["x86_64"] // Ensuring we get x86_64 architecture
  }
}

resource "aws_instance" "ec2-one" {
  ami           = data.aws_ami.linux2.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.shared_subnet.id
  tags          = var.tags
}

/*
This example demonstrates the use of data sources
 in Terraform to dynamically fetch existing AWS resources
  such as VPCs, Subnets, and AMIs.
   The configuration retrieves the default VPC and a specific subnet
    within that VPC based on their Name tags. It also fetches the most
     recent Amazon Linux 2 AMI available in the specified region.
      Finally, it provisions an EC2 instance using the fetched AMI
       and subnet, applying the specified instance type and tags.
*/