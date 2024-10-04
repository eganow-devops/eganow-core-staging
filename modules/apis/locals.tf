resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig.yaml"
  content  = var.k8s_kubeconfig
}