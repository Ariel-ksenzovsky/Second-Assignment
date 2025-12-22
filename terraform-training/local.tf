locals {
  env = terraform.workspace

  # Per-environment sizing
  sizes = {
    dev = {
      web_count = 1
      app_count = 1
      db_replicas = 0
    }
    staging = {
      web_count = 2
      app_count = 2
      db_replicas = 0
    }
    prod = {
      web_count = 3
      app_count = 3
      db_replicas = 2 # "replicas" in prod (see note above)
    }
  }

  cfg = lookup(local.sizes, local.env, local.sizes["dev"])
}

locals {
      docker_network = "web-net-${terraform.workspace}"
    }

locals {
    app_base_ports = {
    dev     = 8080
    staging = 9080
    prod    = 10080
  }

  app_base_port = lookup(local.app_base_ports, terraform.workspace, 8080)
}

locals {
    web_base_ports = {
    dev     = 5000
    staging = 6000
    prod    = 7000
  }

  web_base_port = lookup(local.web_base_ports, terraform.workspace, 5000)
}