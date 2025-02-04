output "rds_endpoint" {
  value = aws_db_instance.ecf_rds.endpoint
  description = "The endpoint of the RDS instance"
}
