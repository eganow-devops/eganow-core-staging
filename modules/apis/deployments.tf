resource "kubernetes_deployment_v1" "eganow_core_merchant" {
  metadata {
    name      = "eganow-core-merchant"
    namespace = var.project_namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "eganow-core-merchant"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-core-merchant"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          name              = "eganow-core-merchant"
          image             = "eganowdevops/eganow-global-merchant-go-api:latest"
          image_pull_policy = "Always"
          port {
            name           = "grpc"
            container_port = 443
          }
          port {
            name           = "rest"
            container_port = 80
          }

          env {
            name  = "API_VERSION"
            value = "0.0.2-staging"
          }

          env {
            name  = "GRPC_SERVER_PORT"
            value = "443"
          }

          env {
            name  = "HTTP_SERVER_PORT"
            value = "80"
          }

          env {
            name  = "ENV"
            value = "staging"
          }

          env {
            name  = "OP_CONNECT_HOST"
            value = var.onepassword_connect_host
          }

          env {
            name = "OP_CONNECT_TOKEN"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.onepassword_key_vault.metadata.0.name
                key  = "op_token"
              }
            }
          }

          env {
            name = "OP_VAULT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.onepassword_key_vault.metadata.0.name
                key  = "op_vault"
              }
            }
          }

          env {
            name = "DB_VAULT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.onepassword_key_vault.metadata.0.name
                key  = "op_db_vault"
              }
            }
          }
        }
      }
    }
  }
}