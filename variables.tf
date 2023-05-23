variable "configuration" {
  type        = string
  description = "The name of the configuration which is used to create the resource"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster which the configuration resides in"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket which the configuration resides in"
}

variable "bucket_acl" {
  type        = string
  description = "The canned ACL to apply to the bucket"
  default     = "private"
}

variable "environment" {
  type        = string
  description = "The environment which the configuration resides in"
}

variable "eks_issuer_url" {
  type        = string
  description = "Is the URL of the OIDC issuer of the EKS cluster."
}

variable "namespace" {
  type        = string
  description = "Is the namespace of the service account."
}

variable "service_account_name" {
  type        = string
  description = "Is the name of the service account."
}

variable "bucket_control_object_ownership" {
  type        = bool
  description = "Whether to control object ownership using IAM roles for service accounts."
  default     = true
}

variable "bucket_object_ownership" {
  type        = string
  description = "The type of object ownership."
  default     = "ObjectWriter"
}

variable "enable_bucket_versioning" {
  type        = bool
  description = "Whether to enable versioning for the S3 bucket."
  default     = true
}
