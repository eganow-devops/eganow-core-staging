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
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_key
}

provider "kubernetes" {
  config_path = local_file.kubeconfig.filename
}

provider "kubectl" {
  config_path = local_file.kubeconfig.filename
}

provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
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
        cloudflare = {
          email = var.cluster_issuer_email
          apiKeySecretRef = {
            name = kubernetes_secret_v1.cloudflare_dns_token.metadata.0.name
            key  = "token"
          }
        }
      },
      selector = {
        dnsZones = [
          var.domain_name
        ]
      }
    }
  ]

  providers = {
    kubernetes = kubernetes
    kubectl    = kubectl
    helm       = helm
  }
}
