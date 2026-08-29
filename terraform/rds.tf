resource "aws_db_subnet_group" "postgres" {
  name = "devops-${var.project_name}-postgres-subnet-group"

  subnet_ids = aws_subnet.private[*].id

  tags = {
    name    = "devops-${var.project_name}-postgres-subnet-group"
    Project = var.project_name
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "byte-devops-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class        = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 30
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.postgres.name
  vpc_security_group_ids = [aws_security_group.database.id]

  publicly_accessible = false

  backup_retention_period = 0

  multi_az = false

  deletion_protection = false
  skip_final_snapshot = true

  tags = {
    Name    = "${var.project_name}-postgres"
    Project = var.project_name
  }
}