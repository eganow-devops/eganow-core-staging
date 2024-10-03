/*resource "helm_release" "balance_redis" {
  chart      = "redis-ha"
  name       = "balance"
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
}*/
