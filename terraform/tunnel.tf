resource "cloudflare_zero_trust_tunnel_cloudflared" "homelab_tunnel" {
  account_id    = var.cloudflare_account_id
  name          = local.tunnel_name
  tunnel_secret = random_bytes.tunnel_secret.base64
}

resource "random_bytes" "tunnel_secret" {
  length = 32
}

# Configure the tunnel (optional - can also use local YAML)
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "homelab_tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.homelab_tunnel.id

  config = {
    ingress = [{
      hostname = "memos-2.${var.cloudflare_domain}"
      service  = "http://memos:5230"
      path     = "subpath"
      }, {
      service = "http_status:404"
      }
    ]
  }
}

# Create credentials file for Docker setup
resource "local_file" "tunnel_credentials" {
  content = jsonencode({
    AccountTag   = var.cloudflare_account_id
    TunnelSecret = random_bytes.tunnel_secret.base64
    TunnelID     = cloudflare_zero_trust_tunnel_cloudflared.homelab_tunnel.tunnel_secret
  })
  filename        = "${path.module}/cloudflared/credentials.json"
  file_permission = "0600"
}
