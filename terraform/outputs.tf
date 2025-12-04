data "cloudflare_zero_trust_tunnel_cloudflared_token" "tunnel_token" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab_tunnel.id
}

output "tunnel_token" {
  sensitive = true
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.tunnel_token.token
}