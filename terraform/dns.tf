resource "cloudflare_dns_record" "memos" {
  name    = "memos-2.${var.cloudflare_domain}"
  ttl     = 0
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.homelab_tunnel.id}.cfargotunnel.com"
  zone_id = var.cloudflare_zone_id
}