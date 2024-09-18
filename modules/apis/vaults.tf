resource "helm_release" "onepassword" {
  chart      = "connect"
  name       = "onepassword-connect"
  repository = "https://1password.github.io/connect-helm-charts"
  version    = var.onepassword_connect_version
  namespace  = var.project_namespace

  cleanup_on_fail = true

  set {
    name  = "connect.credentialsName"
    value = kubernetes_secret_v1.onepassword_connect.metadata.0.name
  }

  set {
    name  = "connect.credentialsKey"
    value = "onepassword-credentials"
  }

  #     set {
  #       name  = "connect.credentials_base64"
  #       value = kubernetes_secret_v1.onepassword_connect.data.onepassword-credentials
  #     }

  set {
    name  = "operator.create"
    value = "true"
  }

  set {
    name  = "operator.autoRestart"
    value = "true"
  }

  set {
    name  = "operator.token.value"
    value = kubernetes_secret_v1.onepassword_connect.data.token
  }

  set {
    name  = "connect.api.httpPort"
    value = var.insecure_port
  }
}