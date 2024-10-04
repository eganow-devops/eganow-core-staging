resource "linode_lke_cluster" "core_cluster" {
  region      = var.cluster_region
  label       = var.cluster_label
  k8s_version = var.cluster_k8s_version
  tags        = var.cluster_tags

  pool {
    type = "g6-standard-2"
    autoscaler {
      max = 3
      min = 1
    }
  }
}
