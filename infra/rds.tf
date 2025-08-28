resource "aws_db_instance" "postgres" {
  identifier        = "${replace(var.project_name, "_", "-")}-db"
  allocated_storage = 20
  engine            = "postgres"
  engine_version    = "17.4"
  instance_class    = "db.t4g.micro"
  db_name           = "digitalbank"

  username = jsondecode(aws_secretsmanager_secret_version.db_credentials_version.secret_string)["username"]
  password = jsondecode(aws_secretsmanager_secret_version.db_credentials_version.secret_string)["password"]

  publicly_accessible   = true
  skip_final_snapshot   = true
  deletion_protection   = false

  tags = {
    Name = "${var.project_name}-postgres"
  }

  depends_on = [aws_secretsmanager_secret_version.db_credentials_version]
}
