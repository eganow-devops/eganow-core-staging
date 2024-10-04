resource "local_file" "kubeconfig" {
  filename = "${path.module}/eganow-core-staging.yaml"
  content  = var.k8s_kubeconfig
}