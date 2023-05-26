variable "configuration" {
  type        = string
  description = "The name of the Terranetes Configuration resource (used in IAM resource names and tags)"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "bucket_acl" {
  type        = string
  description = "The canned ACL to apply to the bucket"
  default     = "private"
}

variable "environment" {
  type        = string
  description = "The environment name"
  default     = "prod"
}

variable "eks_issuer_arn" {
  type        = string
  description = "The ARN of the OIDC issuer for the EKS cluster"
}

variable "namespace" {
  type        = string
  description = "The Kubernetes Namespace that the Service Account resides in"
}

variable "service_account_name" {
  type        = string
  description = "The name of the Kubernetes Service Account to grant permissions to"
}

variable "bucket_control_object_ownership" {
  type        = bool
  description = "Whether to manage S3 Bucket Ownership Controls on this bucket"
  default     = true
}

variable "bucket_object_ownership" {
  type        = string
  description = "The type of object ownership"
  default     = "ObjectWriter"

  validation {
    condition     = can(regex("^ObjectWriter|BucketOwnerPreferred|BucketOwnerEnforced$", var.bucket_object_ownership))
    error_message = "bucket_object_ownership must be one of: ObjectWriter, BucketOwnerPreferred, BucketOwnerEnforced"
  }
}

variable "enable_bucket_versioning" {
  type        = bool
  description = "Whether to enable versioning for the S3 bucket"
  default     = true
}
