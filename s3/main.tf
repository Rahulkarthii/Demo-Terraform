provider "aws" {
  region = "eu-central-1"  # Replace with your desired AWS region
}

resource "aws_s3_bucket" "bucket" {
  count         = var.s3_bucket_create ? 1 : 0
  bucket        = var.resource_name
  force_destroy = true
  tags = merge(var.tags,
    {
      Name      = "${var.resource_name}"
      CreatedOn = formatdate("YYYY-MM-DD'T'00:00:00Z", timeadd(timestamp(), "24h"))
  })
}

resource "aws_s3_bucket_public_access_block" "access" {
  count  = var.s3_bucket_public_access ? 1 : 0
  bucket = var.bucket_name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  count = var.s3_bucket_versioning_create && var.s3_bucket_create ? 1 : 0

  bucket = aws_s3_bucket.bucket[0].id  # Use the ID of the created bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encription_mode" {
  count = var.s3_encryption_configuration_create ? 1 : 0

  bucket = var.bucket_name

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_object" "path" {
  count  = var.s3_object_create ? 1 : 0
  bucket = var.bucket_name
  key    = var.key_path
  source = var.source_key_path
}

locals {
  bucket_policy_path = null
  bucket_policy_vars = {}
}

data "template_file" "bucket_policy" {
  count    = var.create_bucket_policy ? 1 : 0
  template = local.bucket_policy_path
  vars     = local.bucket_policy_vars
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.create_bucket_policy ? 1 : 0
  bucket = var.bucket_name
  policy = data.template_file.bucket_policy[count.index].rendered
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count = var.create_bucket_lifecycle ? 1 : 0

  depends_on = [aws_s3_bucket_versioning.versioning]
  bucket     = var.bucket_name

  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      id     = rule.value.id
      status = rule.value.status

      filter {
        prefix = rule.value.prefix
      }

      noncurrent_version_expiration {
        noncurrent_days = rule.value.ver_noncurrent_days
      }

      dynamic "noncurrent_version_transition" {
        for_each = try(flatten([rule.value.noncurrent_version_transitions]), [])

        content {
          noncurrent_days = noncurrent_version_transition.value.noncurrent_days
          storage_class   = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count = var.create_s3_notification ? 1 : 0

  bucket = var.bucket_name

  dynamic "topic" {
    for_each = var.sns_notifications

    content {
      id            = topic.key
      topic_arn     = var.sns_topic_arn
      events        = topic.value.events
      filter_prefix = try(topic.value.filter_prefix, null)
      filter_suffix = try(topic.value.filter_suffix, null)
    }
  }
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  count = var.create_s3_notification_lambda ? 1 : 0

  bucket = var.bucket_name

  lambda_function {
    id                  = var.lambda_event_id
    lambda_function_arn = var.lambda_function_arn
    events              = var.lambda_events
    filter_prefix       = var.lambda_filter_prefix
    filter_suffix       = var.lambda_filter_suffix
  }
}