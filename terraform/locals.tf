locals {
  urls = {
    memos = {
      hostname = "memos.${var.domain}"
      service  = "http://memos:5230"
    }
    vaultwarden = {
      hostname = "passwords.${var.domain}"
      service  = "http://vaultwarden:8080"
    }
  }
}