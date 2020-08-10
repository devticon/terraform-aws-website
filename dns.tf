resource "aws_route53_record" "main" {
  name    = var.domain
  type    = "A"
  zone_id = data.aws_route53_zone.main.id

  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
  }
}
