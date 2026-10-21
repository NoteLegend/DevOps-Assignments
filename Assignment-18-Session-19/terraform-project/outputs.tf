output "vpc_id" {
  value = aws_vpc.course.id
}
output "subnet_id" {
  value = aws_subnet.course.id
}
output "instance_id" {
  value = aws_instance.course.id
}
output "bucket_name" {
  value = aws_s3_bucket.course.id
}
