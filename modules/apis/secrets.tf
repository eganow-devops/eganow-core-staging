resource "kubernetes_secret_v1" "do_dns_token" {
  metadata {
    name      = "digitalocean-dns"
    namespace = var.cluster_issuer_name
  }

  data = {
    token = var.do_token
  }
}

resource "kubernetes_secret_v1" "onepassword_key_vault" {
  metadata {
    name      = "onepassword-key-vault"
    namespace = var.project_namespace
  }

  data = {
    "op_token"    = var.onepassword_auth_jwt
    "op_vault"    = var.onepassword_vault_uuid
    "op_db_vault" = var.onepassword_vault_db_uuid
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