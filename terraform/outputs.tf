output "instance_ip_addr" {
  value = aws_instance.web.public_ip
}
# Output the default VPC ID
output "default_vpc_id" {
  description = "The ID of the default VPC."
  value       = data.aws_vpc.default.id
}
