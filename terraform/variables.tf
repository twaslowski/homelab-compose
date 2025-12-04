variable "cloudflare_api_key" {
  description = "The API key for Cloudflare."
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "The Cloudflare account ID."
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID."
  type        = string
}

variable "cloudflare_domain" {
  description = "The domain name for the homelab services."
  type        = string
}

variable "tunnel_name" {
  description = "The name of the Cloudflare Tunnel."
  type        = string
}

