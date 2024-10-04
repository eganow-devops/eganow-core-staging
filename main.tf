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

# module "apis" {
#   source                       = "./modules/apis"
#   k8s_kubeconfig               = module.cluster.eganow_cluster_kubeconfig
#   k8s_provider_token           = var.linode_api_key
#   cluster_issuer_email         = var.cluster_issuer_email
#   do_token                     = var.do_token
#   dockerconfigjson             = var.dockerconfigjson
#   domain_name                  = var.domain_name
#   onepassword_token            = var.onepassword_token
#   onepassword_credentials_json = var.onepassword_credentials_json
# }
