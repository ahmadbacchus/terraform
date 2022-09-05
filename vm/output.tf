output "instance_ip_addr" {
  value       = aws_instance.app_server.private_ip
  description = "The private IP address of the main server instance."
}

output "vpc_id" {
  value       = aws_vpc.main.tags
  description = "The VPC Arn that was created"
}
