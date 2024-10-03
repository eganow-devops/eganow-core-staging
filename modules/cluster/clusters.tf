resource "vultr_kubernetes" "core_cluster" {
  region  = var.cluster_region
  label   = var.cluster_label
  version = var.cluster_k8s_version

  node_pools {
    node_quantity = 1
    plan          = "vc2-1c-2gb"
    label         = "vke-nodepool"
    auto_scaler   = true
    min_nodes     = 3
    max_nodes     = 5
  }
}
