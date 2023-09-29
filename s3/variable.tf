variable "s3_bucket_create" {
  description = "Specify to create S3 bucket or not"
  type        = bool
  default     = true
}

variable "resource_name" {
  description = "Specifies AWS Resource name."
  type        = string
  default     = "project-bucket754"
}

variable "bucket_name" {
  description = "Specifies S3 bucket name to create S3 bucket."
  type        = string
  default     = "75400qwe"
}

variable "s3_bucket_versioning_create" {
  description = "Specify to create S3 bucket with versioning or not"
  type        = bool
  default     = true
}

variable "s3_encryption_configuration_create" {
  description = "Specify to create S3 bucket server side encryption configuration or not"
  type        = bool
  default     = false
}

variable "create_bucket_lifecycle" {
  description = "Specify to create S3 lifecycle policy or not for S3 bucket."
  type        = bool
  default     = false
}

variable "create_s3_notification" {
  description = "Specify to create S3 notification or not"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

variable "sns_notifications" {
  description = "Map of S3 bucket notifications to SNS topic"
  type        = any
  default     = {}
}

variable "kms_key_id" {
  description = "AWS KMS master key ID used for the SSE-KMS encryption"
  type        = string
  default     = null
}
variable "sse_algorithm" {
  description = "Specifies s3 sse_algorithm."
  type        = string
  default     = "SSE-KMS"
}

variable "sns_topic_arn" {
  description = "AWS SNS Topic ARN to notify event"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags that will be applied to the aws resource"
  type        = map(string)
  default     = null
}

variable "bucket_policy_path" {
  type        = string
  default     = null
  description = "Template file path for bucket policy policy creation. if you don't want policy then put value as 'null'. "
}

variable "bucket_policy_vars" {
  description = "Template variables to insert into policy file."
  type        = map(string)
  default     = {}
}

variable "create_bucket_policy" {
  description = "Specify to create S3 bucket policy or not"
  type        = bool
  default     = false
}


variable "s3_object_create" {
  description = "Specify to create S3 bucket object or not"
  type        = bool
  default     = false
}

variable "key_path" {
  type        = string
  default     = null
  description = "provide the key path to generate, make sure to put '/' end of the folder to generate it. e.g.- 'test/123/'"
}

variable "source_key_path" {
  type        = string
  default     = null
  description = "provide the key path to generate, make sure to put '/' end of the folder to generate it. e.g.- 'test/123/'"
}

variable "create_s3_notification_lambda" {
  description = "Specify to create trigger for lambda function on S3 bucket object creation"
  type        = bool
  default     = false
}

variable "lambda_events" {
  description = "list of event of S3 bucket to trigger lambda function"
  type        = list(string)
  default     = []
}

variable "lambda_function_arn" {
  description = "AWS Lambda function ARN to trigger on put event"
  type        = string
  default     = null
}

variable "lambda_filter_prefix" {
  description = "Object key name prefix."
  type        = string
  default     = null
}

variable "lambda_filter_suffix" {
  description = "lambda_filter_suffix."
  type        = string
  default     = null
}

variable "lambda_event_id" {
  description = "Unique identifier for each of the notification configurations."
  type        = string
  default     = null
}

variable "s3_bucket_public_access" {
  description = "Specify to enable public access or not"
  type        = bool
  default     = false
}
variable "account_id" {
  description = "AWS Account ID"
  type        = string
}