locals {
  urls = {
    memos = {
      hostname = "memos.${var.domain}"
      service  = "http://memos:5230"
    }
    recipes = {
      hostname = "recipes.${var.domain}"
      service  = "http://tandoor:80"
    }
    vaultwarden = {
      hostname = "passwords.${var.domain}"
      service  = "http://vaultwarden:8080"
    }
  }
}
