resource "aws_iam_policy" "bucket_policy" {
  description = "Allow"
  name        = local.name
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
          module.bucket.s3_bucket_arn
        ]
      }
    ]
  })
}
