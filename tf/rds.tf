# RDS specifies the source of replication so dr is deployed second

module "rds" {
  source   = "./modules/rds"
  for_each = var.primary_rds_config

  environment               = each.key
  identifier                = each.value.identifier
  engine                    = each.value.engine
  engine_version            = each.value.engine_version
  instance_class            = each.value.instance_class
  allocated_storage         = each.value.allocated_storage
  maintenance_window        = each.value.maintenance_window
  backup_window             = each.value.backup_window
  create_db_option_group    = each.value.create_db_option_group
  create_db_parameter_group = each.value.create_db_parameter_group
  create_db_subnet_group    = each.value.create_db_subnet_group
  create_monitoring_role    = each.value.create_monitoring_role
  username                  = each.value.username
}


module "dr_rds" {
  providers = {
    aws = aws.dr
  }
  source   = "./modules/rds"
  for_each = var.dr_rds_config

  environment               = each.key
  identifier                = each.value.identifier
  engine                    = each.value.engine
  engine_version            = each.value.engine_version
  instance_class            = each.value.instance_class
  allocated_storage         = each.value.allocated_storage
  maintenance_window        = each.value.maintenance_window
  backup_window             = each.value.backup_window
  create_db_option_group    = each.value.create_db_option_group
  create_db_parameter_group = each.value.create_db_parameter_group
  create_db_subnet_group    = each.value.create_db_subnet_group
  create_monitoring_role    = each.value.create_monitoring_role
  replicate_source_db       = each.value.replica ? module.rds[each.key].db_instance_endpoint : null
  username                  = each.value.username
  depends_on = [
    module.rds
  ]
}