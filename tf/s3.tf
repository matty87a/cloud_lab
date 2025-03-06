
# S3 specifies the target of replication so dr is deployed first
module "dr_s3_buckets" {
  providers = {
    aws = aws.dr
  }
  source = "./modules/s3"

  for_each                = merge([for env, buckets in var.dr_buckets : { for bucket, config in buckets : "${env}-${bucket}" => config }]...)
  environment             = each.key
  bucket_name             = each.value.bucket_name
  force_destroy           = each.value.force_destroy
  acl                     = each.value.acl
  pii                     = each.value.pii
  block_public_acls       = each.value.block_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
  versioning              = each.value.versioning
  website                 = lookup(each.value, "website", "")
  lifecycle_rules         = each.value.lifecycle_rules
  tags                    = each.value.tags
  replication_rules       = each.value.replication_rules
}

module "s3_buckets" {
  source = "./modules/s3"

  for_each                = merge([for env, buckets in var.primary_buckets : { for bucket, config in buckets : "${env}-${bucket}" => config }]...)
  environment             = each.key
  bucket_name             = each.value.bucket_name
  force_destroy           = each.value.force_destroy
  acl                     = each.value.acl
  pii                     = each.value.pii
  block_public_acls       = each.value.block_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
  versioning              = each.value.versioning
  website                 = lookup(each.value, "website", "")
  lifecycle_rules         = each.value.lifecycle_rules
  tags                    = each.value.tags
  replication_rules       = each.value.replication_rules
  depends_on = [
    module.dr_s3_buckets,
  ]
}
