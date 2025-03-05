variable "environment" {

}
variable "bucket_name" {

}

variable "force_destroy" {

}

variable "acl" {

}

variable "pii" {

}

variable "block_public_acls" {

}

variable "restrict_public_buckets" {

}

variable "versioning" {

}

variable "website" {

}

variable "lifecycle_rules" {

}

variable "tags" {

}

variable "replication_rules" {
  type    = any
  default = {}
}


#     bucket_name            = string
#     force_destroy          = bool
#     acl                    = string
#     pii                    = bool
#     block_public_acls      = bool
#     restrict_public_buckets = bool
#     versioning             = object({
#       enabled = bool
#     })
#     website                = optional(object({
#       index_document = string
#       error_document = string
#     }))
#     lifecycle_rules = list(object({
#       id       = string
#       enabled  = bool
#       prefix   = string
#       expiration = object({
#         days = number
#       })
#     }))
#     tags = map(string)
#   })))
# }