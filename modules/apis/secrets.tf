resource "kubernetes_secret_v1" "cloudflare_dns_token" {
  metadata {
    name      = "cloudflare-dns"
    namespace = var.cluster_issuer_name
  }

  data = {
    token = var.cloudflare_global_api_key
  }
}

resource "kubernetes_secret_v1" "onepassword_connect" {
  metadata {
    name      = "onepassword-connect"
    namespace = var.project_namespace
  }

  data = {
    "onepassword-credentials" = base64encode(jsonencode(var.onepassword_credentials_json))
    token             = var.onepassword_token
    host              = "https://${cloudflare_record.onepassword_vault.name}.${var.domain_name}"
    vault             = "5mvgadepgjjlouxo43mg5ycsoy"
    merchant_db_vault = "xkbn6xwxrptyjxdv2kcet4fmta"
  }
}

resource "kubernetes_secret_v1" "docker_regcred" {
  metadata {
    name      = "docker-regcred"
    namespace = var.project_namespace
  }

  data = {
    ".dockerconfigjson" = jsonencode(var.dockerconfigjson)
  }
}