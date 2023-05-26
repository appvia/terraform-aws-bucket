output "bucket" {
  description = "The ARN of the bucket"
  value       = module.bucket.s3_bucket_arn
}
