/*resource "kubernetes_service_v1" "eganow_core_merchant" {
  metadata {
    name      = "${kubernetes_deployment_v1.eganow_core_merchant.metadata.0.name}-svc"
    namespace = var.project_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.eganow_core_merchant.spec.0.selector.0.match_labels.app
    }

    port {
      name        = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.0.name
      port        = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.0.container_port
    }
    port {
      name        = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.1.name
      port        = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.1.container_port
      target_port = kubernetes_deployment_v1.eganow_core_merchant.spec.0.template.0.spec.0.container.0.port.1.container_port
    }
  }
}*/

resource "kubernetes_service_v1" "payment_gateway" {
  metadata {
    name      = "${kubernetes_deployment_v1.payment_gateway.metadata.0.name}-svc"
    namespace = var.project_namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment_v1.payment_gateway.spec.0.selector.0.match_labels.app
    }

    port {
      name        = "grpc"
      port        = kubernetes_deployment_v1.payment_gateway.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.payment_gateway.spec.0.template.0.spec.0.container.0.port.0.container_port
    }
  }
}

// TODO: one-password
/*data "kubernetes_service_v1" "onepassword_connect" {
  metadata {
    name      = helm_release.onepassword_connect.name
    namespace = var.project_namespace
  }
}*/

resource "kubernetes_service_v1" "eganow_developers" {
  metadata {
    name      = "${kubernetes_deployment_v1.eganow_developers.metadata.0.name}-svc"
    namespace = var.project_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.eganow_developers.spec.0.selector.0.match_labels.app
    }
    port {
      port        = kubernetes_deployment_v1.eganow_developers.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.eganow_developers.spec.0.template.0.spec.0.container.0.port.0.container_port
      name        = "http"
    }
  }
}

resource "kubernetes_service_v1" "egapay_payout" {
  metadata {
    name      = "${kubernetes_deployment_v1.egapay_payout_api.metadata.0.name}-svc"
    namespace = var.project_namespace
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.egapay_payout_api.spec.0.selector.0.match_labels.app
    }
    port {
      port        = kubernetes_deployment_v1.egapay_payout_api.spec.0.template.0.spec.0.container.0.port.0.container_port
      target_port = kubernetes_deployment_v1.egapay_payout_api.spec.0.template.0.spec.0.container.0.port.0.container_port
      name        = "http"
    }
  }
}