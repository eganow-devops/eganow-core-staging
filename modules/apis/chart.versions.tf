variable "redis_ha_version" {
  description = "The version of the Redis HA chart"
  type        = string
  default     = "4.27.1"
}

variable "nginx_ingress_version" {
  description = "The version of the Nginx Ingress chart"
  type        = string
  default     = "4.11.1"
}
variable "onepassword_connect_version" {
  description = "The version of the 1Password Connect chart"
  type        = string
  default     = "1.15.1"
}