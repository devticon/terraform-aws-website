variable "domain" {
  type = string
}

variable "origin_bucket_name" {
  type    = string
  default = ""
}

variable "cache_compress" {
  type    = bool
  default = true
}

variable "cache_max_ttl" {
  type    = number
  default = 86400
}

variable "cache_min_ttl" {
  type    = number
  default = 0
}

variable "cache_default_ttl" {
  type    = number
  default = 3600
}

variable "cache_enable" {
  type    = bool
  default = true
}

variable "router_enable" {
  type    = bool
  default = true
}

variable "on_404_path" {
  type    = string
  default = "/404/index.html"
}

variable "on_404_code" {
  type    = number
  default = 404
}

variable "www_alias_enable" {
  type    = bool
  default = true
}

variable "dns_aliases" {
  type    = list(string)
  default = []
}
