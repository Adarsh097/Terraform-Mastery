resource "random_id" "bucket_id" {
  byte_length = 4

}
resource "aws_s3_bucket" "bucket1" {
  bucket = "${local.formatted_project_name}-bucket-${random_id.bucket_id.hex}"

  tags = local.formatted_tags
}

