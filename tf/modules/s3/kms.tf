resource "aws_kms_key" "objects" {
  enable_key_rotation     = true
  rotation_period_in_days = 90
  deletion_window_in_days = 30
  policy                  = data.aws_iam_policy_document.kms_policy.json
}

resource "aws_kms_alias" "objects" {
  name          = "alias/${var.environment}-${var.bucket_name}-object-key"
  target_key_id = aws_kms_key.objects.key_id
}