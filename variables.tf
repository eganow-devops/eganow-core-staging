variable "vultr_api_key" {
  description = "The token for vultr cluster"
  sensitive   = true
}

variable "do_token" {
  description = "The token for digitalocean account"
  sensitive   = true
}

variable "cluster_issuer_email" {
  description = "The email of the cluster issuer"
  type        = string
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
  default = {
    auths = {
      "dummy" = {
        username = ""
        password = ""
        email    = ""
        auth     = ""
      }
    }
  }
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