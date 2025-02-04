resource "aws_db_instance" "ecf_rds" {
    allocated_storage            = 20
    max_allocated_storage = 30
    engine                       = "mysql"
    engine_version               = "8.0"
    identifier                   = "ecfrds"
    instance_class               = "db.t4g.micro"
    password                     = var.dbpassword
    skip_final_snapshot          = true
    storage_encrypted            = false
    publicly_accessible          = false
    username                     = var.dbusername
    apply_immediately            = true
    enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]
    vpc_security_group_ids = [var.security_group_id]
  }