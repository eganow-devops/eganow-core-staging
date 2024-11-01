resource "helm_release" "eu_card_redis" {
  chart      = "redis-ha"
  name       = "eu-card"
  repository = "https://dandydeveloper.github.io/charts/"
  version    = var.redis_ha_version
  namespace  = var.project_namespace

  cleanup_on_fail = true

  set {
    name  = "haproxy.enabled"
    value = "true"
  }
  set {
    name  = "haproxy.service.type"
    value = "LoadBalancer"
  }
}
