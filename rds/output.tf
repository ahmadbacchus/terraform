output "rds_endpoint" {
  value       = aws_db_instance.default.endpoint
  description = "The RDS Endpoint that was created"
}
