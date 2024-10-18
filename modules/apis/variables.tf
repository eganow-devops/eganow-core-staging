variable "k8s_kubeconfig" {
  description = " The kubeconfig file from the cluster"
  type        = string
}

variable "cluster_issuer_email" {
  description = "The email of the cluster issuer"
  type        = string
}

variable "cluster_issuer_name" {
  description = "The name of the cluster issuer"
  type        = string
  default     = "eganow-cert-manager"
}

variable "cluster_issuer_private_key_secret_name" {
  description = "The name of the secret that contains the private key of the cluster issuer"
  type        = string
  default     = "cert-manager-private-key"
}

variable "project_namespace" {
  type        = string
  description = "project default namespace"
  default     = "ns-eganow-core"
}

# variable "onepassword_auth_jwt" {
#   type        = string
#   description = "The JWT token for 1Password"
#   sensitive   = true
# }
#
# variable "onepassword_vault_uuid" {
#   type        = string
#   description = "The UUID of the vault in 1Password"
#   sensitive   = true
# }
#
# variable "onepassword_vault_db_uuid" {
#   type        = string
#   description = "The UUID of the default database item in 1Password vault"
#   sensitive   = true
# }
#
# variable "onepassword_connect_host" {
#   type        = string
#   description = "The host of the 1Password Connect service"
# }

variable "dockerconfigjson" {
  description = "Docker config JSON needed to set up image pull credentials"
  type = object({
    auths = map(object({
      username = string
      password = string
      email    = string
      auth     = string
    }))
  })
  sensitive = true
}
variable "onepassword_credentials_json" {
  description = "The name of the secret that contains the 1password credentials"
  type = object({
    verifier = object({
      salt      = string
      localHash = string
    })
    encCredentials = object({
      kid  = string
      enc  = string
      cty  = string
      iv   = string
      data = string
    })
    version    = string
    deviceUuid = string
    uniqueKey = object({
      alg = string
      ext = bool
      k   = string
      key_ops = list(string)
      kty = string
      kid = string
    })
  })
}
variable "ingress_namespace" {
  description = "The namespace of the ingress"
  type        = string
  default     = "ns-cores-ingress"
}

variable "domain_name" {
  description = "The domain name of the project"
  type        = string
}
variable "min_pod_replicas" {
  description = "The minimum number of replicas for the deployment"
  type        = number
  default     = 1
}

variable "max_pod_replicas" {
  description = "The maximum number of replicas for the deployment"
  type        = number
  default     = 3
}

variable "http_ingress_tls_secret_name" {
  description = "The name of the secret that contains the TLS certificate"
  type        = string
  default     = "http-ingress-tls"
}

variable "grpc_ingress_tls_secret_name" {
  description = "The name of the secret that contains the TLS certificate"
  type        = string
  default     = "grpc-ingress-tls"
}

variable "insecure_port" {
  description = "The port for insecure service"
  type        = number
  default     = 8080
}

variable "secure_port_name" {
  description = "The port for secure service"
  type        = string
  default     = "https"
}

variable "onepassword_token" {
  description = "The token for vault connection"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "The ID for the cloudflare account"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The ID for the cloudflare zone"
  type        = string
}

variable "cloudflare_api_key" {
  description = "The API key for cloudflare account"
  type        = string
}

variable "cloudflare_global_api_key" {
  description = "The API key for cloudflare account"
  type        = string
}

variable "cloudflare_project_name" {
  description = "The name of the cloudflare project"
  type        = string
}

variable "cloudflare_dns_ttl" {
  description = "The TTL of the zone to facilitate DNS records."
  type        = number
  default     = 3600
}

variable "cloudflare_dns_ttl_proxied" {
  description = "The TTL of the zone to facilitate DNS records."
  type        = number
  default     = 1
}