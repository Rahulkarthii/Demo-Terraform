output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = try(aws_s3_bucket.bucket[0].arn, "")
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = try(aws_s3_bucket.bucket[0].region, "")
}

output "s3_bucket_id" {
  description = "Name of the bucket."
  value       = try(aws_s3_bucket.bucket[0].id, "")
}

output "s3_bucket_bucket_domain_name" {
  description = "The AWS Bucket domain name."
  value       = try(aws_s3_bucket.bucket[0].bucket_domain_name, "")
}