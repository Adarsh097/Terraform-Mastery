//conditional expression to set the instance type based on environment variable
resource "aws_instance" "instance1" {
  ami           = var.region == "ap-south-1" ? "ami-087d1c9a513324697" : "ami-0c55b159cbfafe1f0"
  instance_type = var.environment == "production" ? "t3.micro" : "t2.micro"
  count         = var.instance_count
  region        = var.region
  tags          = var.tags
}


resource "aws_security_group" "ingress_rules" {
  name = "sg"
  # ingress {
  # from_port = 80
  # to_port = 80
  # protocol = "http"
  # cidr_blocks = [ "0.0.0.0/0" ]
  # description = "HTTP"
  # }

  # DYNAMIC BLOCK TO CREATE MULTIPLE INGRESS RULES BASED ON THE VARIABLE DEFINED IN VARIABLES.TF
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All traffic"
  }

}