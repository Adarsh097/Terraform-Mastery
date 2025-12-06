/*
Assignment 1: Project Naming ⭐
Transform "Project ALPHA Resource" → "project-alpha-resource"

Functions: lower(), replace()
Status: ✅ Active by default
*/
// See the locals.tf for implementation


/*
Assignment 2: Resource Tagging ⭐
Merge default and environment tags

Function: merge()

*/
// See the locals.tf for implementation




/*
Assignment 3: S3 Bucket Naming ⭐⭐
Sanitize bucket names for AWS compliance

Functions: substr(), replace(), lower()

*/

resource "aws_s3_bucket" "bucket2" {
    bucket = local.bucket_name
  
}