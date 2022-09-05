output "instance_ip_addr" {
  value       = aws_instance.app_server
  description = "The private IP address of the main server instance."
}

output "vpc_id" {
  value       = aws_vpc.main
  description = "The VPC Arn that was created"
}


output "opsview" {
  value       = null_resource.register_with_opsview
  description = "The VPC Arn that was created"
}


output "cmdb" {
  value       = null_resource.register_with_cmdb
  description = "The VPC Arn that was created"
}