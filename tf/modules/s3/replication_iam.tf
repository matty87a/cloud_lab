resource "aws_iam_role" "s3_replication_role" {
  count = var.replication_rules != [] ? 1 : 0

  name = "${var.environment}-${var.bucket_name}-replication-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

data "aws_iam_policy_document" "s3_replication_policy_document" {
  count = length(var.replication_rules)
  statement {
    sid = "sourceBucketPerms"
    actions = [
      "s3:GetReplicationConfiguration",
      "s3:ListBucket"
    ]
    effect = "Allow"
    resources = [
      module.s3_bucket.s3_bucket_arn
    ]
  }
  statement {
    sid = "sourceBucketObjectPerms"
    actions = [
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl"
    ]
    effect = "Allow"
    resources = [
      "${module.s3_bucket.s3_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_policy" "s3_replication_policy" {
  count  = length(var.replication_rules)
  name   = "s3-replication-policy-${var.replication_rules[count.index].id}"
  policy = data.aws_iam_policy_document.s3_replication_policy_document[count.index].json
}

resource "aws_iam_role_policy_attachment" "s3_replication_attachment" {
  count      = length(var.replication_rules)
  role       = aws_iam_role.s3_replication_role[0].name
  policy_arn = aws_iam_policy.s3_replication_policy[count.index].arn
}