variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "bucket_name" {
  type        = string
  description = "A globally unique S3 name chosen by the owner before approved execution."
}
