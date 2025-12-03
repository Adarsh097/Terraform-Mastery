// Declare the input variables here
// input variable
variable "environment" {
  default = "development"
  type    = string
}

variable "region" {
  default = "ap-south-1"
  type    = string
}

variable "tags" {
  type = map(string)
  default = {
    Name       = "dev-instance"
    created_by = "terraform"


  }

}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instance to be created"
}

# ingress_rules[] = [object1, object2, ....]
variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
    }, {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }]
}
