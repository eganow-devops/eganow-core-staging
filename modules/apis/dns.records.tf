resource "digitalocean_domain" "core" {
  name = var.domain_name
}

resource "digitalocean_record" "eganow_merchant" {
  domain = digitalocean_domain.core.id
  type   = "A"
  name   = "merchant"
  value  = data.kubernetes_service_v1.ingress_lb.status.0.load_balancer.0.ingress.0.ip
}