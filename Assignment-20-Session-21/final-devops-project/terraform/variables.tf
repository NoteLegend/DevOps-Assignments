variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
variable "bucket_name" {
  type = string
}
variable "ami_id" {
  type        = string
  description = "Owner must supply a valid Ubuntu 24.04 amd64 AMI for the chosen region before any approved plan."
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "container_image" {
  type        = string
  description = "Owner-published public final application image or immutable digest; replace placeholder before approved cloud plan."
  validation {
    condition     = can(regex("^[A-Za-z0-9._/:@-]+$", var.container_image))
    error_message = "Use a registry image reference without whitespace or shell metacharacters."
  }
}
