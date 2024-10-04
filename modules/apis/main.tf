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
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.39.2"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  config_path = var.k8s_kubeconfig
  token       = var.k8s_provider_token
}

provider "kubectl" {
  config_path      = var.k8s_kubeconfig
  token            = var.k8s_provider_token
  load_config_file = false
}

provider "helm" {
  kubernetes {
    config_path = var.k8s_kubeconfig
    token       = var.k8s_provider_token
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


