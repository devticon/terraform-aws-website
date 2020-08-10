module "cert" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"
  providers = {
    aws = aws.virgina
  }
  domain_name = var.domain
  zone_id     = data.aws_route53_zone.main.id

  subject_alternative_names = [
    "*.${var.domain}",
  ]
}
