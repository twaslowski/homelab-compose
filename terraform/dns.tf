resource "cloudflare_dns_record" "record" {
  for_each = local.urls

  name    = each.value.hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.homelab_tunnel.id}.cfargotunnel.com"

  ttl     = 1 # automatic
  proxied = true
  zone_id = var.cloudflare_zone_id
  comment = "managed-by:terraform;service:${each.key}"
}