// configure where the terraform state files will be stored
terraform {
  backend "s3" {
    bucket       = "adarsh-s3-statefile-bucket-1"
    key          = "dev/terraform.tfstate" // path within the bucket
    region       = "ap-south-1"
    encrypt      = true // to enable server-side encryption
    use_lockfile = true // to prevent concurrent modifications using S3 object locking
  }
}