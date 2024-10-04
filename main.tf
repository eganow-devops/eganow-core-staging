terraform {
  cloud {
    organization = "eganow-devops-org"
    workspaces {
      name = "eganow-core-uat-ws"
    }
  }
}

# register cluster module
module "cluster" {
  source         = "./modules/cluster"
  linode_api_key = var.linode_api_key
}

module "apis" {
  source               = "./modules/apis"
  k8s_kubeconfig       = module.cluster.eganow_cluster_kubeconfig
  k8s_provider_token   = var.linode_api_key
  cluster_issuer_email = var.cluster_issuer_email

  dockerconfigjson = var.dockerconfigjson

  onepassword_token            = var.onepassword_token
  onepassword_credentials_json = var.onepassword_credentials_json

  domain_name             = var.domain_name
  cloudflare_account_id   = var.cloudflare_account_id
  cloudflare_zone_id      = var.cloudflare_zone_id
  cloudflare_api_key      = var.cloudflare_api_key
  cloudflare_project_name = var.cloudflare_project_name
}
