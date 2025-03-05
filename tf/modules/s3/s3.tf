data "aws_caller_identity" "current" {}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket        = "${var.environment}-${var.bucket_name}"
  acl           = var.acl
  force_destroy = var.force_destroy
  versioning    = var.versioning
  website       = var.website != null ? var.website : {}

  block_public_acls       = var.block_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.objects.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  lifecycle_rule      = var.lifecycle_rules
  allowed_kms_key_arn = aws_kms_key.objects.arn

  tags = merge(var.tags, {
    managed-by = "terraform-aws-modules/s3-bucket/aws" # Allows you to see which TF module manages these resources, in addition to the repo
  })

  depends_on = [
    aws_iam_role.s3_replication_role
  ]
}

resource "aws_s3_bucket_policy" "s3_policy" {

  bucket = module.s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_policy.json
}