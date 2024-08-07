variable "k8s_ca_certificate" {
  description = " The ca certificate from the cluster"
  type        = string
}

variable "k8s_id" {
  description = "The id from the cluster"
  type        = string
}

variable "k8s_client_key" {
  type = string
}

variable "k8s_client_cert" {
  type = string
}

variable "k8s_host" {
  description = "The host from the k8s cluster"
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

variable "do_token" {
  description = "The token for digitalocean account"
  sensitive   = true
}

variable "project_namespace" {
  type        = string
  description = "project default namespace"
  default     = "ns-eganow-staging"
}

variable "onepassword_auth_jwt" {
  type        = string
  description = "The JWT token for 1Password"
  sensitive   = true
}

variable "onepassword_vault_uuid" {
  type        = string
  description = "The UUID of the vault in 1Password"
  sensitive   = true
}

variable "onepassword_vault_db_uuid" {
  type        = string
  description = "The UUID of the default database item in 1Password vault"
  sensitive   = true
}

variable "onepassword_connect_host" {
  type        = string
  description = "The host of the 1Password Connect service"
}

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

variable "ingress_namespace" {
  description = "The namespace of the ingress"
  type        = string
  default     = "ns-cores-ingress"
}

variable "ingress_tls_secret_name" {
  description = "The name of the secret that contains the TLS certificate"
  type        = string
  default     = "http-ingress-tls"
}