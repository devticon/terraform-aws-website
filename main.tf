provider "aws" {
  alias  = "virgina"
  region = "us-east-1"
}

locals {
  domain_parts     = split(".", var.domain)
  hosted_zone_name = "${join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts)))}."

}

data "aws_route53_zone" "main" {
  name = local.hosted_zone_name
}
