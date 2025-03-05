primary_networking = {
  vpc_name           = "primary-vpc"
  vpc_cidr           = "10.0.0.0/17"
  enable_nat_gateway = true
  public_subnets = [
    { cidr_block = "10.10.1.0/24", availability_zone = "eu-west-1a" },
    { cidr_block = "10.10.2.0/24", availability_zone = "eu-west-1b" }
  ]
  private_subnets = [
    { cidr_block = "10.10.7.0/24", availability_zone = "eu-west-1a" },
    { cidr_block = "10.10.8.0/24", availability_zone = "eu-west-1b" }
  ]
  tags = {
    owner = "networks"
  }
}


dr_networking = {
  vpc_name           = "dr-vpc"
  vpc_cidr           = "10.0.128.0/17"
  enable_nat_gateway = true
  public_subnets = [
    { cidr_block = "10.10.128.0/24", availability_zone = "eu-west-1a" },
    { cidr_block = "10.10.129.0/24", availability_zone = "eu-west-1b" }
  ]

  private_subnets = [
    { cidr_block = "10.10.130.0/24", availability_zone = "eu-west-1a" },
    { cidr_block = "10.10.131.0/24", availability_zone = "eu-west-1b" }
  ]
  tags = {
    owner = "networks"
  }
}

primary_rds_config = {
  dev = {
    identifier = "db1"

    engine                    = "mysql"
    engine_version            = "5.7"
    instance_class            = "db.t3a.large"
    allocated_storage         = 5
    maintenance_window        = "Mon:00:00-Mon:03:00"
    backup_window             = "03:00-06:00"
    create_db_option_group    = false
    create_db_parameter_group = false
    create_db_subnet_group    = false
    create_monitoring_role    = true
    replicate_source_db       = null
    username                  = "db_user"

  },
  staging = {
    identifier = "db1"

    engine                    = "mysql"
    engine_version            = "5.7"
    instance_class            = "db.t3a.large"
    allocated_storage         = 5
    maintenance_window        = "Mon:00:00-Mon:03:00"
    backup_window             = "03:00-06:00"
    create_db_option_group    = false
    create_db_parameter_group = false
    create_db_subnet_group    = false
    create_monitoring_role    = true
    replicate_source_db       = null
    username                  = "db_user"
  },
  qa = {
    identifier = "db1"

    engine                    = "mysql"
    engine_version            = "5.7"
    instance_class            = "db.t3a.large"
    allocated_storage         = 5
    maintenance_window        = "Mon:00:00-Mon:03:00"
    backup_window             = "03:00-06:00"
    create_db_option_group    = false
    create_db_parameter_group = false
    create_db_subnet_group    = false
    create_monitoring_role    = true
    replicate_source_db       = null
    username                  = "db_user"
  }
}

primary_buckets = {
  dev = {
    logs = {
      bucket_name             = "dev-logs-bucket"
      force_destroy           = false
      acl                     = "log-delivery-write"
      pii                     = false
      block_public_acls       = true
      restrict_public_buckets = true
      versioning = {
        enabled = true
      }
      lifecycle_rules = [
        {
          id      = "log-expiration"
          enabled = true
          prefix  = "logs/"
          expiration = {
            days = 90
          }
        }
      ]
      tags = {
        Environment = "dev"
        Owner       = "security-team"
      }
    },

    assets = {
      bucket_name             = "assets-bucket"
      force_destroy           = true
      acl                     = "public-read"
      pii                     = false
      block_public_acls       = false
      restrict_public_buckets = false
      versioning = {
        enabled = true
      }
      website = {
        index_document = "index.html"
        error_document = "error.html"
      }
      lifecycle_rules = []
      tags = {
        Environment = "dev"
        Owner       = "frontend-team"
      }
      replication_rules = [
        {
          id       = "everything-with-filter"
          status   = "Enabled"
          priority = 30

          delete_marker_replication = true
          filter = {
            prefix = "one"
            tags = {
              ReplicateMe = "Yes"
            }
          }

          destination = {
            bucket        = "arn:aws:s3:::dr-assets-bucket"
            storage_class = "STANDARD"
          }
        },
        {
          id     = "everything-without-filters"
          status = "Enabled"


          destination = {
            bucket        = "arn:aws:s3:::$dr-assets-bucket"
            storage_class = "STANDARD"
          }
        },
      ]
    }
  }
}


dr_rds_config = {
  staging = {
    identifier                = "stagingdb-dr"
    replicate_source_db       = "stagingdb"
    engine                    = "mysql"
    engine_version            = "5.7"
    instance_class            = "db.t3a.large"
    allocated_storage         = 5
    maintenance_window        = "Mon:00:00-Mon:03:00"
    backup_window             = "03:00-06:00"
    create_db_option_group    = false
    create_db_parameter_group = false
    create_db_subnet_group    = false
    create_monitoring_role    = true
    replica                   = true
    username                  = "db_user"
    replica                   = true
  }
}

dr_buckets = {
  staging = {
    assets = {
      bucket_name             = "dr-assets-bucket"
      force_destroy           = true
      acl                     = "public-read"
      pii                     = false
      block_public_acls       = false
      restrict_public_buckets = false
      versioning = {
        enabled = true
      }
      website = {
        index_document = "index.html"
        error_document = "error.html"
      }
      lifecycle_rules = []
      tags = {
        Environment = "dev"
        Owner       = "frontend-team"
      }
    }
  }
}