resource "aws_vpc" "course" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = { Name = "devops-course" }
}
resource "aws_subnet" "course" {
  vpc_id                  = aws_vpc.course.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  map_public_ip_on_launch = true
}
resource "aws_security_group" "course" {
  name_prefix = "devops-course-"
  description = "Owner-approval-pending HTTP application; no SSH ingress."
  vpc_id      = aws_vpc.course.id
}
resource "aws_instance" "course" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  user_data                   = templatefile("${path.module}/bootstrap.sh.tftpl", { image = var.container_image })
  depends_on                  = [aws_route_table_association.course, aws_vpc_security_group_egress_rule.outbound]
  subnet_id                   = aws_subnet.course.id
  vpc_security_group_ids      = [aws_security_group.course.id]
  metadata_options {
    http_tokens = "required"
  }
  root_block_device {
    encrypted = true
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

# Prepared cloud application route; no cloud operation is executed by validation.
resource "aws_internet_gateway" "course" {
  vpc_id = aws_vpc.course.id
}
resource "aws_route_table" "course" {
  vpc_id = aws_vpc.course.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.course.id
  }
}
resource "aws_route_table_association" "course" {
  subnet_id      = aws_subnet.course.id
  route_table_id = aws_route_table.course.id
}
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.course.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}
resource "aws_vpc_security_group_egress_rule" "outbound" {
  security_group_id = aws_security_group.course.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
