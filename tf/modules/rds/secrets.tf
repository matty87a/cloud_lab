resource "aws_secretsmanager_secret" "rds" {
  name = "${var.environment}-rds-secret"
}

resource "aws_secretsmanager_secret_version" "rds" {
  secret_id     = aws_secretsmanager_secret.rds.id
  secret_string = "example-string-to-protect"
}

