locals {
  domain_parts     = split(".", var.domain)
  hosted_zone_name = "${join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts)))}."

}

data "aws_route53_zone" "payticon_com" {
  name = local.hosted_zone_name
}

module "cert" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v2.0"
  providers = {
    aws = aws.virgina
  }
  domain_name = var.domain
  zone_id     = data.aws_route53_zone.payticon_com.id

  subject_alternative_names = [
    "*.${var.domain}",
  ]
}
