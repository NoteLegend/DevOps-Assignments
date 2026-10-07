resource "aws_s3_bucket" "assignment" {
  bucket = var.bucket_name
  tags   = { Project = "DevOpsAssignment18" }
}
resource "aws_s3_bucket_public_access_block" "assignment" {
  bucket                  = aws_s3_bucket.assignment.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
