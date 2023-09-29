provider "aws" {
  region = "eu-central-1"  # Replace with your desired AWS region
}

module "Terra" {
  source                                = "../s3"
  s3_bucket_create                      = var.s3_bucket_create
  resource_name                         = var.resource_name
  bucket_name                           = var.bucket_name
  s3_bucket_versioning_create           = var.s3_bucket_versioning_create
  s3_encryption_configuration_create    = var.s3_encryption_configuration_create
  create_bucket_lifecycle               = var.create_bucket_lifecycle
  create_s3_notification                = var.create_s3_notification
  lifecycle_rules                       = var.lifecycle_rules
  sns_notifications                     = var.sns_notifications
  kms_key_id                            = var.kms_key_id
  sse_algorithm                         = var.sse_algorithm
  s3_object_create                      = var.s3_object_create
  create_s3_notification_lambda         = var.create_s3_notification_lambda
  s3_bucket_public_access               = var.s3_bucket_public_access
  account_id                            = 570059307819

}