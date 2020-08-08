locals {
  s3_origin_id = "S3-Origin"
}

resource "aws_cloudfront_origin_access_identity" "main" {
}

resource "aws_cloudfront_distribution" "main" {
  enabled = true

  default_root_object = "index.html"

  aliases = [
    var.domain,
    "www.${var.domain}"
  ]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.router.qualified_arn
    }
  }


  origin {
    domain_name = aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = module.cert.this_acm_certificate_arn
    ssl_support_method  = "sni-only"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/404/index.html"
  }
}
