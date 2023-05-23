
#
## IAM Permissions to the S3 bucket
#
resource "aws_iam_policy" "bucket_policy" {
  depends_on = [
    module.bucket
  ]

  description = "Allow"
  name        = format("%s-%s", var.configuration, var.environment)
  path        = "/"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Access",
        "Effect" : "Allow",
        "Action" : [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::${bucket}"
        ]
      }
    ]
  })
}
