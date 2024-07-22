terraform {
  cloud {
    organization = "eganow-devops-org"
    workspaces {
      name = "eganow-devops-ws"
    }
  }
}
