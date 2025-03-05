module "db" {
  source                    = "terraform-aws-modules/rds/aws"
  identifier                = "${var.environment}-${var.identifier}"
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  allocated_storage         = var.allocated_storage
  maintenance_window        = var.maintenance_window
  backup_window             = var.backup_window
  create_db_option_group    = var.create_db_option_group
  create_db_parameter_group = var.create_db_parameter_group
  create_db_subnet_group    = var.create_db_subnet_group
  create_monitoring_role    = var.create_monitoring_role
  replicate_source_db       = var.replicate_source_db
  monitoring_role_name      = "${var.environment}-${var.identifier}-mon-role"
  username                  = var.username
}