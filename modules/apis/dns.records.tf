resource "cloudflare_record" "eganow_merchant" {
  zone_id = var.cloudflare_zone_id
  type    = "A"
  name    = "merchant.core"
  content = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
  ttl     = var.cloudflare_dns_ttl
  proxied = false
}

resource "cloudflare_record" "payment_gateway" {
  zone_id = var.cloudflare_zone_id
  name    = "gateway.core"
  type    = "A"
  content = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
  ttl     = var.cloudflare_dns_ttl
  proxied = false
}

resource "cloudflare_record" "onepassword_vault" {
  zone_id = var.cloudflare_zone_id
  name    = "vault.core"
  type    = "A"
  content = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
  ttl     = var.cloudflare_dns_ttl
  proxied = false
}

resource "cloudflare_record" "eganow_developers" {
  zone_id = var.cloudflare_zone_id
  name    = "developers.core"
  type    = "A"
  content = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
  ttl     = var.cloudflare_dns_ttl
  proxied = false
}

resource "cloudflare_record" "egapay_payout" {
  zone_id = var.cloudflare_zone_id
  name    = "payout.core"
  type    = "A"
  content = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
  ttl     = var.cloudflare_dns_ttl
  proxied = false
}