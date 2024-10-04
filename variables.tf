variable "linode_api_key" {
  description = "The token for Linode k8s cluster"
  sensitive   = true
}

variable "cluster_issuer_email" {
  description = "The email of the cluster issuer"
  type        = string
}
variable "dockerconfigjson" {
  type = object({
    auths = map(object({
      username = string
      password = string
      email    = string
      auth     = string
    }))
  })
  description = "Docker config JSON"
  sensitive   = true
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

variable "onepassword_token" {
  description = "The token for vault connection"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "The domain name for the project"
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

variable "cloudflare_project_name" {
  description = "The name of the cloudflare project"
  type        = string
}