locals {
  origin_bucket_name = var.origin_bucket_name != "" ? var.origin_bucket_name : var.domain
}

data "aws_iam_policy_document" "web_distribution" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.main.iam_arn]
    }
    resources = ["${aws_s3_bucket.origin.arn}/*"]
  }
}

resource "aws_s3_bucket" "origin" {
  bucket = local.origin_bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_policy" "origin" {
  bucket = aws_s3_bucket.origin.id
  policy = data.aws_iam_policy_document.web_distribution.json
}
