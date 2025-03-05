variable "primary_networking" {
  description = "Networking configuration for primary VPC and subnets."
  type = object({
    vpc_name           = string
    vpc_cidr           = string
    enable_nat_gateway = bool
    public_subnets = list(
      object({
        cidr_block        = string
        availability_zone = string
      })
    )
    private_subnets = list(
      object({
        cidr_block        = string
        availability_zone = string
      })
    )
    tags = map(string)
  })
}

variable "dr_networking" {
  description = "Networking configuration for DR VPC and subnets."
  type = object({
    vpc_name           = string
    vpc_cidr           = string
    enable_nat_gateway = bool
    public_subnets = list(
      object({
        cidr_block        = string
        availability_zone = string
      })
    )
    private_subnets = list(
      object({
        cidr_block        = string
        availability_zone = string
      })
    )
    tags = map(string)
  })
}


variable "primary_rds_config" {
  description = "Configuration for primary RDS"
  type = map(object({
    identifier                = string
    engine                    = string
    engine_version            = string
    instance_class            = string
    allocated_storage         = number
    maintenance_window        = string
    backup_window             = string
    create_db_option_group    = bool
    create_db_parameter_group = bool
    create_db_subnet_group    = bool
    create_monitoring_role    = bool
    replicate_source_db       = string
    username                  = string
  }))
}


variable "dr_rds_config" {
  description = "Configuration for DR RDS"
  type = map(object({
    identifier                = string
    engine                    = string
    engine_version            = string
    instance_class            = string
    allocated_storage         = number
    maintenance_window        = string
    backup_window             = string
    create_db_option_group    = bool
    create_db_parameter_group = bool
    create_db_subnet_group    = bool
    create_monitoring_role    = bool
    replicate_source_db       = string
    username                  = string
    replica                   = bool

  }))
}




variable "primary_buckets" {
  type = map(map(object({
    bucket_name             = string
    force_destroy           = bool
    acl                     = string
    pii                     = bool
    block_public_acls       = bool
    restrict_public_buckets = bool

    versioning = object({
      enabled = bool
    })

    website = optional(object({
      index_document = string
      error_document = string
    }), null)

    lifecycle_rules = list(object({
      id      = string
      enabled = bool
      prefix  = string
      expiration = object({
        days = number
      })
    }))

    replication_rules = optional(list(object({
      id       = string
      status   = string
      priority = optional(number)

      delete_marker_replication = optional(bool, false)

      filter = optional(object({
        prefix = string
        tags   = optional(map(string))
      }))

      destination = object({
        bucket        = string
        storage_class = string
      })
    })), [])

    tags = map(string)
  })))
}



variable "dr_buckets" {
  type = map(map(object({
    bucket_name             = string
    force_destroy           = bool
    acl                     = string
    pii                     = bool
    block_public_acls       = bool
    restrict_public_buckets = bool

    versioning = object({
      enabled = bool
    })

    website = optional(object({
      index_document = string
      error_document = string
    }), null)

    lifecycle_rules = list(object({
      id      = string
      enabled = bool
      prefix  = string
      expiration = object({
        days = number
      })
    }))

    replication_rules = optional(list(object({
      id       = string
      status   = string
      priority = optional(number)

      delete_marker_replication = optional(bool, false)

      filter = optional(object({
        prefix = string
        tags   = optional(map(string))
      }))

      destination = object({
        bucket        = string
        storage_class = string
      })
    })), [])

    tags = map(string)
  })))
}
