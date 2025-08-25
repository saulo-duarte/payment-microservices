resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "${var.project_name}_db_credentials"
  description = "Credenciais do banco Postgres"
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "admin"
    password = "ChangeMe123!"
  })
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
}
