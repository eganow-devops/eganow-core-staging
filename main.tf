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
  source        = "./modules/cluster"
  vultr_api_key = var.vultr_api_key
}

module "apis" {
  source                    = "./modules/apis"
  k8s_ca_certificate        = module.cluster.eganow_cluster_kubeconfig_ca_cert
  k8s_id                    = module.cluster.eganow_cluster_id
  k8s_host                  = module.cluster.eganow_cluster_kubeconfig_host
  k8s_client_cert           = module.cluster.eganow_cluster_kubeconfig_client_cert
  k8s_client_key            = module.cluster.eganow_cluster_kubeconfig_client_key
  cluster_issuer_email      = var.cluster_issuer_email
  do_token                  = var.do_token
  onepassword_auth_jwt      = var.onepassword_auth_jwt
  onepassword_connect_host  = var.onepassword_connect_host
  onepassword_vault_db_uuid = var.onepassword_vault_db_uuid
  onepassword_vault_uuid    = var.onepassword_vault_uuid
  dockerconfigjson          = var.dockerconfigjson
  domain_name               = var.domain_name
}
