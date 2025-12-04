locals {
  urls = {
    memos = {
      hostname = "memos-b.${var.cloudflare_domain}"
      service  = "http://memos:5230"
    }
  }
}