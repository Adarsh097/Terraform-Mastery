// configure the terraform providers here

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" // will upgrade to latest 6.x version and not 7.x
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.primary
  alias  = "primary"
}

provider "aws" {
  region = var.secondary
  alias  = "secondary"
}