resource "kubernetes_namespace_v1" "core_namespace" {
  metadata {
    name = var.project_namespace
  }
}