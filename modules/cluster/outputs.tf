output "eganow_cluster_id" {
  value = vultr_kubernetes.core_cluster.id
}

output "eganow_cluster_kubeconfig_host" {
  value = "https://97b7d67b-4cb0-4a95-be51-bc4a66214525.vultr-k8s.com:6443" #vultr_kubernetes.core_cluster.endpoint
}

output "eganow_cluster_kubeconfig_ca_cert" {
  value = base64decode(vultr_kubernetes.core_cluster.cluster_ca_certificate)
}

output "eganow_cluster_kubeconfig_client_cert" {
  value = base64decode(vultr_kubernetes.core_cluster.client_certificate)
}

output "eganow_cluster_kubeconfig_client_key" {
  value = base64decode(vultr_kubernetes.core_cluster.client_key)
}