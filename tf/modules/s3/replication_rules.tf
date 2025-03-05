# this is a much simplified replication resource for illustration
resource "aws_s3_bucket_replication_configuration" "this" {
  count  = length(var.replication_rules) > 0 ? 1 : 0
  bucket = module.s3_bucket.s3_bucket_id
  role   = aws_iam_role.s3_replication_role[0].arn

  dynamic "rule" {
    for_each = var.replication_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      priority = contains(keys(rule.value), "priority") ? rule.value.priority : null


      dynamic "filter" {
        for_each = rule.value.filter != null ? [rule.value.filter] : []
        content {
          and {
            prefix = try(filter.value.prefix, null)
            tags   = try(filter.value.tags, null)
          }
        }
      }

      destination {
        bucket        = rule.value.destination.bucket
        storage_class = rule.value.destination.storage_class
      }
    }
  }
}
