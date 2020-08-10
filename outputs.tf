output "origin_bucket" {
  value = aws_s3_bucket.origin.bucket
}

output "cert_arn" {
  value = module.cert.this_acm_certificate_arn
}
