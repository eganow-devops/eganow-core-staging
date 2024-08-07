variable "cluster_k8s_version" {
  description = "The Kubernetes version for the cluster"
  type        = string
  default     = "v1.30.0+1"
}

variable "cluster_label" {
  description = "The label for the cluster"
  type        = string
  default     = "eganow-core-staging"
}

variable "cluster_region" {
  description = "The region for the cluster"
  type        = string
  default     = "fra"
}

variable "cluster_tags" {
  description = "The tags for the cluster"
  type = list(string)
  default = ["eganow-core-staging", "terraform:linode"]
}

variable "cluster_pools" {
  description = "The Node Pool specifications for the Kubernetes cluster. (required)"
  type = list(object({
    type  = string
    count = number
  }))
  default = [
    {
      type  = "g6-standard-1"
      count = 3
    }
  ]
}

variable "bucket_region" {
  type    = string
  default = "eu-central"
}

variable "vultr_api_key" {
  type = string
}