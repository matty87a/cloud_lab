<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.86.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dr_rds"></a> [dr\_rds](#module\_dr\_rds) | ./modules/rds | n/a |
| <a name="module_dr_s3_buckets"></a> [dr\_s3\_buckets](#module\_dr\_s3\_buckets) | ./modules/s3 | n/a |
| <a name="module_dr_vpc"></a> [dr\_vpc](#module\_dr\_vpc) | ./modules/networking | n/a |
| <a name="module_primary_vpc"></a> [primary\_vpc](#module\_primary\_vpc) | ./modules/networking | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_s3_buckets"></a> [s3\_buckets](#module\_s3\_buckets) | ./modules/s3 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dr_buckets"></a> [dr\_buckets](#input\_dr\_buckets) | n/a | <pre>map(map(object({<br/>    bucket_name             = string<br/>    force_destroy           = bool<br/>    acl                     = string<br/>    pii                     = bool<br/>    block_public_acls       = bool<br/>    restrict_public_buckets = bool<br/><br/>    versioning = object({<br/>      enabled = bool<br/>    })<br/><br/>    website = optional(object({<br/>      index_document = string<br/>      error_document = string<br/>    }), null)<br/><br/>    lifecycle_rules = list(object({<br/>      id      = string<br/>      enabled = bool<br/>      prefix  = string<br/>      expiration = object({<br/>        days = number<br/>      })<br/>    }))<br/><br/>    replication_rules = optional(list(object({<br/>      id       = string<br/>      status   = string<br/>      priority = optional(number)<br/><br/>      delete_marker_replication = optional(bool, false)<br/><br/>      filter = optional(object({<br/>        prefix = string<br/>        tags   = optional(map(string))<br/>      }))<br/><br/>      destination = object({<br/>        bucket        = string<br/>        storage_class = string<br/>      })<br/>    })), [])<br/><br/>    tags = map(string)<br/>  })))</pre> | n/a | yes |
| <a name="input_dr_networking"></a> [dr\_networking](#input\_dr\_networking) | Networking configuration for DR VPC and subnets. | <pre>object({<br/>    vpc_name           = string<br/>    vpc_cidr           = string<br/>    enable_nat_gateway = bool<br/>    public_subnets = list(<br/>      object({<br/>        cidr_block        = string<br/>        availability_zone = string<br/>      })<br/>    )<br/>    private_subnets = list(<br/>      object({<br/>        cidr_block        = string<br/>        availability_zone = string<br/>      })<br/>    )<br/>    tags = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_dr_rds_config"></a> [dr\_rds\_config](#input\_dr\_rds\_config) | Configuration for DR RDS | <pre>map(object({<br/>    identifier                = string<br/>    engine                    = string<br/>    engine_version            = string<br/>    instance_class            = string<br/>    allocated_storage         = number<br/>    maintenance_window        = string<br/>    backup_window             = string<br/>    create_db_option_group    = bool<br/>    create_db_parameter_group = bool<br/>    create_db_subnet_group    = bool<br/>    create_monitoring_role    = bool<br/>    replicate_source_db       = string<br/>    username                  = string<br/>    replica                   = bool<br/><br/>  }))</pre> | n/a | yes |
| <a name="input_primary_buckets"></a> [primary\_buckets](#input\_primary\_buckets) | n/a | <pre>map(map(object({<br/>    bucket_name             = string<br/>    force_destroy           = bool<br/>    acl                     = string<br/>    pii                     = bool<br/>    block_public_acls       = bool<br/>    restrict_public_buckets = bool<br/><br/>    versioning = object({<br/>      enabled = bool<br/>    })<br/><br/>    website = optional(object({<br/>      index_document = string<br/>      error_document = string<br/>    }), null)<br/><br/>    lifecycle_rules = list(object({<br/>      id      = string<br/>      enabled = bool<br/>      prefix  = string<br/>      expiration = object({<br/>        days = number<br/>      })<br/>    }))<br/><br/>    replication_rules = optional(list(object({<br/>      id       = string<br/>      status   = string<br/>      priority = optional(number)<br/><br/>      delete_marker_replication = optional(bool, false)<br/><br/>      filter = optional(object({<br/>        prefix = string<br/>        tags   = optional(map(string))<br/>      }))<br/><br/>      destination = object({<br/>        bucket        = string<br/>        storage_class = string<br/>      })<br/>    })), [])<br/><br/>    tags = map(string)<br/>  })))</pre> | n/a | yes |
| <a name="input_primary_networking"></a> [primary\_networking](#input\_primary\_networking) | Networking configuration for primary VPC and subnets. | <pre>object({<br/>    vpc_name           = string<br/>    vpc_cidr           = string<br/>    enable_nat_gateway = bool<br/>    public_subnets = list(<br/>      object({<br/>        cidr_block        = string<br/>        availability_zone = string<br/>      })<br/>    )<br/>    private_subnets = list(<br/>      object({<br/>        cidr_block        = string<br/>        availability_zone = string<br/>      })<br/>    )<br/>    tags = map(string)<br/>  })</pre> | n/a | yes |
| <a name="input_primary_rds_config"></a> [primary\_rds\_config](#input\_primary\_rds\_config) | Configuration for primary RDS | <pre>map(object({<br/>    identifier                = string<br/>    engine                    = string<br/>    engine_version            = string<br/>    instance_class            = string<br/>    allocated_storage         = number<br/>    maintenance_window        = string<br/>    backup_window             = string<br/>    create_db_option_group    = bool<br/>    create_db_parameter_group = bool<br/>    create_db_subnet_group    = bool<br/>    create_monitoring_role    = bool<br/>    replicate_source_db       = string<br/>    username                  = string<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
