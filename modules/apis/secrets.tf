resource "kubernetes_secret_v1" "do_dns_token" {
  metadata {
    name      = "digitalocean-dns"
    namespace = var.cluster_issuer_name
  }

  data = {
    token = var.do_token
  }
}

resource "kubernetes_secret_v1" "onepassword_connect" {
  metadata {
    name      = "onepassword-connect"
    namespace = var.project_namespace
  }

  data = {
    "onepassword-credentials" : base64encode(jsonencode(var.onepassword_credentials_json))
    token = var.onepassword_token
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