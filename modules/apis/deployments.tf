/*resource "kubernetes_deployment_v1" "eganow_core_merchant" {
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
            value = kubernetes_secret_v1.onepassword_connect.data.host
          }

          env {
            name = "OP_CONNECT_TOKEN"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.onepassword_connect.metadata.0.name
                key  = "token"
              }
            }
          }

          env {
            name = "OP_VAULT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.onepassword_connect.metadata.0.name
                key  = "vault"
              }
            }
          }

          env {
            name = "DB_VAULT"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.onepassword_connect.metadata.0.name
                key  = "merchant_db_vault"
              }
            }
          }
        }
      }
    }
  }
}*/

resource "kubernetes_deployment_v1" "eganow_backoffice" {
  metadata {
    name      = "eganow-backoffice"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-backoffice"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-backoffice"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/uat-eganow-back-office-project:latest"
          name              = "eganow-backoffice"
          image_pull_policy = "Always"

          port {
            container_port = 8080
            name           = "http"
            protocol       = "TCP"
          }
        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "payment_gateway" {
  metadata {
    name      = "payment-gateway"
    namespace = var.project_namespace
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "payment-gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "payment-gateway"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/uat-eganow-mobile-app-core-api:latest"
          name              = "payment-gateway"
          image_pull_policy = "Always"

          port {
            container_port = 80
            name           = "grpc"
          }

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "groups_gateway" {
  metadata {
    name      = "groups-gateway"
    namespace = var.project_namespace
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "groups-gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "groups-gateway"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/uat-eganow-mobile-app-groups-api:latest"
          name              = "groups-gateway"
          image_pull_policy = "Always"

          port {
            container_port = 80
            name           = "grpc"
          }

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "eganow_developers" {
  metadata {
    name      = "eganow-developers"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-developers"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-developers"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/uat-eganow-developer-api:latest"
          name              = "eganow-developers"
          image_pull_policy = "Always"

          port {
            container_port = 80
            name           = "http"
            protocol       = "TCP"
          }

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_balance_sync_consumer" {
  metadata {
    name      = "eganow-balance-sync"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-balance-sync"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-balance-sync"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-balance-sync-ws:latest"
          name              = "eganow-balance-sync"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_callback_consumer" {
  metadata {
    name      = "eganow-callback-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-callback-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-callback-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-callback-consumer:latest"
          name              = "eganow-callback-consumer"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_db_consumer" {
  metadata {
    name      = "eganow-dbconn-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-dbconn-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-dbconn-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-dbconn-consumer:latest"
          name              = "eganow-dbconn-consumer"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_payout_api" {
  metadata {
    name      = "eganow-payout-api"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-payout-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-payout-api"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-payout-api:latest"
          name              = "eganow-payout-api"
          image_pull_policy = "Always"

          port {
            container_port = 8081
            name           = "http"
            protocol       = "TCP"
          }

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_payout_accounting_consumer" {
  metadata {
    name      = "eganow-payout-accounting-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-payout-accounting-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-payout-accounting-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-payout-accounting-consumer:latest"
          name              = "eganow-payout-accounting-consumer"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_pay_partner_mtn_consumer" {
  metadata {
    name      = "eganow-paypartner-mtn-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-paypartner-mtn-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-paypartner-mtn-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-paypartner-mtn-consumer:latest"
          name              = "eganow-paypartner-mtn-consumer"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_pay_partner_at_consumer" {
  metadata {
    name      = "eganow-paypartner-at-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-paypartner-at-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-paypartner-at-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-paypartner-at-consumer:latest"
          name              = "eganow-paypartner-at-consumer"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_pay_partner_telecel_consumer" {
  metadata {
    name      = "eganow-paypartner-telecel-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-paypartner-telecel-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-paypartner-telecel-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-paypartner-telecel-consumer:latest"
          name              = "eganow-paypartner-telecel-consumer"
          image_pull_policy = "Always"
        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_sender_beneficiary_validation_consumer" {
  metadata {
    name      = "eganow-sender-beneficiary-validation-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-sender-beneficiary-validation-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-sender-beneficiary-validation-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-sender-beneficiary-validation-consumer:latest"
          name              = "eganow-sender-beneficiary-validation-consumer"
          image_pull_policy = "Always"
        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}

resource "kubernetes_deployment_v1" "egapay_transaction_storage_consumer" {
  metadata {
    name      = "eganow-transaction-storage-consumer"
    namespace = var.project_namespace
    labels = {
      scope = "eganow-core-dotnet"
    }
  }

  spec {
    replicas = var.min_pod_replicas

    selector {
      match_labels = {
        app = "eganow-transaction-storage-consumer"
      }
    }

    template {
      metadata {
        labels = {
          app = "eganow-transaction-storage-consumer"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret_v1.docker_regcred.metadata.0.name
        }
        container {
          image             = "eganowdevops/egapay-transaction-storage-consumer:latest"
          name              = "eganow-transaction-storage-consumer"
          image_pull_policy = "Always"

        }
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }
  }
}
