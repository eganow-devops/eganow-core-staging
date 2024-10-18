resource "helm_release" "onepassword_connect" {
  chart      = "connect"
  name       = "onepassword-connect"
  repository = "https://1password.github.io/connect-helm-charts"
  version    = var.onepassword_connect_version
  namespace  = var.project_namespace

  cleanup_on_fail = true

  # Define the values for the chart
  values = [
    <<EOF
    connect:
      credentials: "${kubernetes_secret_v1.onepassword_connect.data.onepassword-credentials}"
    EOF
  ]

  set {
    name  = "connect.api.httpPort"
    value = var.insecure_port
  }

  wait = true
}