<!-- BEGIN_TF_DOCS -->
# Terraform Module: AWS S3 Bucket and IRSA

The "terraform-aws-bucket" Terraform Module provisions and manages an S3 Bucket with IRSA (IAM Roles for Service Accounts). IRSA can be used to grant access to the S3 Bucket from within a Kubernetes cluster, without the need for long lived IAM user credentials.

This module was designed to be used in conjunction with the [Appvia Terranetes Controller](https://github.com/appvia/terranetes-controller).

## Deployment

Provision this Terraform Module by creating a `Configuration` resource in your Kubernetes cluster, as follows:
```yaml
---
apiVersion: terraform.appvia.io/v1alpha1
kind: Configuration
metadata:
  name: s3-bucket
  namespace: apps
spec:
  module: https://github.com/appvia/terraform-aws-bucket?ref=master

  providerRef:
    name: aws

  valueFrom:
    - context: default
      key: eks_oidc_issuer_arn
      name: eks_issuer_arn
    - context: default
      key: eks_name
      name: cluster_name

  variables:
    bucket_name: my-test-s3-bucket
    configuration: s3-bucket
    namespace: apps
    service_account_name: default
```

This has a dependency on a `default` Terranetes Context being available within the Cluster, which contains an `eks_oidc_issuer` and `eks_name`. You can auto-generate the `default` context by updating the aws `Provider` resource in your Kubernetes cluster, as follows (set your aws eks cluster name as appropriate):
```yaml
apiVersion: terraform.appvia.io/v1alpha1
kind: Provider
metadata:
  name: aws
spec:
  source: secret
  provider: aws
  preload:
    enabled: true
    cluster: aws-eks-cluster-name
    region: eu-west-2
    context: default
  secretRef:
    namespace: terraform-system
    name: aws
```

## Updating Docs

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:
1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `terraform-docs markdown table --output-file ${PWD}/README.md --output-mode inject .`

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | The canned ACL to apply to the bucket | `string` | `"private"` | no |
| <a name="input_bucket_control_object_ownership"></a> [bucket\_control\_object\_ownership](#input\_bucket\_control\_object\_ownership) | Whether to manage S3 Bucket Ownership Controls on this bucket | `bool` | `true` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket | `string` | n/a | yes |
| <a name="input_bucket_object_ownership"></a> [bucket\_object\_ownership](#input\_bucket\_object\_ownership) | The type of object ownership | `string` | `"ObjectWriter"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster | `string` | n/a | yes |
| <a name="input_configuration"></a> [configuration](#input\_configuration) | The name of the Terranetes Configuration resource (used in IAM resource names and tags) | `string` | n/a | yes |
| <a name="input_eks_issuer_arn"></a> [eks\_issuer\_arn](#input\_eks\_issuer\_arn) | The ARN of the OIDC issuer for the EKS cluster | `string` | n/a | yes |
| <a name="input_enable_bucket_versioning"></a> [enable\_bucket\_versioning](#input\_enable\_bucket\_versioning) | Whether to enable versioning for the S3 bucket | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name | `string` | `"prod"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes Namespace that the Service Account resides in | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the Kubernetes Service Account to grant permissions to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The ARN of the bucket |
<!-- END_TF_DOCS -->