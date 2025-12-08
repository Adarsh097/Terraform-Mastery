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


/*
Assignment 4: Security Group Rules from Ports ⭐⭐⭐
*/
// see the locals.tf for implementation

/*
Assignment 5: Instance Size Selection ⭐⭐⭐
Dynamically select instance size based on environment
*/
// see the locals.tf for implementation


//--------------------------------------------------------------------------
// Day-12

/*
Assignment 6: Instance Validation

Validate EC2 instance type format and length using Terraform validation functions.
Functions: length(), can(), regex()
*/
// see variables.tf for implementation



/*
Assignment 7: Backup Configuration

Verify backup name structure and handle sensitive values properly.
Functions: endswith(), sensitive()
*/
// see variables.tf for implementation


/*
Assignment 8: File Path Processing

Check whether a file exists and extract directory paths for automation use.
Functions: fileexists(), dirname()
*/
// see locals.tf for implementation

/*
Assignment 9: Location Management

Merge two region lists and remove duplicates using set operations.
Functions: toset(), concat()
*/
// see locals.tf for implementation


/*
Assignment 10: Cost Calculation

Calculate resource cost after applying usage credits and ensure non-negative output.
Functions: abs(), max(), sum()
*/
