terraform {
  backend "s3" {
    bucket = "246770851643-eu-central-1-terraform-state"
    key    = "homelab/cloudflare.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_key
}

