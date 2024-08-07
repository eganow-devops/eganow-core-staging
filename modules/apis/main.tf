terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
    }
  }
}

provider "kubernetes" {
  cluster_ca_certificate = var.k8s_ca_certificate
  client_certificate     = var.k8s_client_cert
  client_key             = var.k8s_client_key
  host                   = var.k8s_host
}

provider "kubectl" {
  cluster_ca_certificate = var.k8s_ca_certificate
  client_certificate     = var.k8s_client_cert
  client_key             = var.k8s_client_key
  host                   = var.k8s_host
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = var.k8s_ca_certificate
    client_certificate     = var.k8s_client_cert
    client_key             = var.k8s_client_key
    host                   = var.k8s_host
  }
}

module "cert_manager" {
  source         = "terraform-iaac/cert-manager/kubernetes"
  version        = "2.6.3"
  namespace_name = var.cluster_issuer_name

  cluster_issuer_email                   = var.cluster_issuer_email
  cluster_issuer_name                    = var.cluster_issuer_name
  cluster_issuer_private_key_secret_name = var.cluster_issuer_private_key_secret_name

  solvers = [
    {
      dns01 = {
        digitalocean = {
          tokenSecretRef = {
            name = kubernetes_secret_v1.do_dns_token.metadata.0.name
            key  = "token"
          }
        }
      }
    }
  ]

  providers = {
    kubernetes = kubernetes
    kubectl    = kubectl
    helm       = helm
  }

}


