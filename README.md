# terraform-aws-website

##Basic setup
```hcl-terraform
module "website" {
  source  = "devticon/website/aws"
  version = "~> 1.0"
  
  domain: "test-domain.devticon.com"
}
```
