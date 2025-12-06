locals {
  urls = {
    memos = {
      hostname = "memos.${var.domain}"
      service  = "http://memos:5230"
    }
  }
}