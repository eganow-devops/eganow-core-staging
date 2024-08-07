resource "kubernetes_service_v1" "eganow_core_merchant" {
  metadata {
    name      = "${kubernetes_deployment_v1.eganow_core_merchant.metadata.0.name}-svc"
    namespace = var.project_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.eganow_core_merchant.spec.0.selector.0.match_labels.app
    }

    port {
      name        = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.1.name
      port        = 443
      target_port = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.1.container_port
    }

    # NB: gRPC port disabled for now
  }
}