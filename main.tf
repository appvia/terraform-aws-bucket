

locals {
  tags = {
    Cluster       = "${var.cluster_name}"
    Configuration = format("%s/%s", var.namespace, var.configuration)
    Environment   = "${var.environment}"
    Terranetes    = "true"
  }
}

## Provision the bucket
module "bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.10.1"

  acl                      = var.bucket_acl
  bucket                   = var.bucket_name
  control_object_ownership = var.bucket_control_object_ownership
  force_destroy            = true
  object_ownership         = var.bucket_object_ownership
  tags                     = local.tags

  versioning = {
    enabled = var.enable_bucket_versioning
  }
}

## Provision the access for the service account
module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.20.0"

  role_name = format("%s-%s-%s", var.environment, var.namespace, var.configuration)
  role_policy_arns = {
    policy = "${aws_iam_policy.bucket_policy.arn}"
  }
  tags = local.tags

  oidc_providers = {
    main = {
      provider_arn               = "${var.eks_issuer_url}"
      namespace_service_accounts = ["${var.namespace}:${var.service_account_name}"]
    }
  }
}

