resource "kubernetes_namespace_v1" "pay_partners_namespace" {
  metadata {
    name = var.project_namespace
  }
}