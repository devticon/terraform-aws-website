provider "aws" {
  alias  = "virgina"
  region = "us-east-1"
}

locals {
  domain_parts     = split(".", var.domain)
  hosted_zone_name = "${join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts)))}."
  dns_aliases = var.www_alias_enable ? concat(["www.${var.domain}"], var.dns_aliases) : var.dns_aliases
}

data "aws_route53_zone" "main" {
  name = local.hosted_zone_name
}
