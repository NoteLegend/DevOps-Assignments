resource "aws_vpc" "course" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = { Name = "devops-course" }
}
resource "aws_subnet" "course" {
  vpc_id                  = aws_vpc.course.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  map_public_ip_on_launch = false
}
resource "aws_security_group" "course" {
  name_prefix = "devops-course-"
  description = "Private course EC2 instance; no public ingress."
  vpc_id      = aws_vpc.course.id
}
resource "aws_instance" "course" {
  ami                         = var.ami_id
  associate_public_ip_address = false
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.course.id
  vpc_security_group_ids      = [aws_security_group.course.id]
  metadata_options {
    http_tokens = "required"
  }
  root_block_device {
    encrypted             = true
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
  }
  credit_specification {
    cpu_credits = "standard"
  }
  tags = { Name = "devops-course" }
}
resource "aws_s3_bucket" "course" {
  bucket = var.bucket_name
}
resource "aws_s3_bucket_public_access_block" "course" {
  bucket                  = aws_s3_bucket.course.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
