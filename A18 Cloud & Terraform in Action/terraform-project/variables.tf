variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
variable "bucket_name" {
  type = string
}
variable "ami_id" {
  type        = string
  description = "Owner must supply a valid Linux AMI for the chosen region before any approved plan."
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}
