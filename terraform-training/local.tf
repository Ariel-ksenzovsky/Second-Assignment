locals {
  # unique network per workspace so dev/staging/prod can run together
  docker_network = "web-net-${terraform.workspace}"

  # per-environment sizing + base ports
  sizes = {
    dev = {
      web_count     = 1
      app_count     = 1
      db_replicas   = 0
      web_base_port = 8080
      app_base_port = 9000

    }
    staging = {
      web_count     = 2
      app_count     = 2
      db_replicas   = 0
      web_base_port = 9080
      app_base_port = 9100
    }
    prod = {
      web_count     = 3
      app_count     = 3
      db_replicas   = 2
      web_base_port = 10080
      app_base_port = 10100
    }
  }

  cfg = lookup(local.sizes, terraform.workspace, local.sizes["dev"])

  # convenience locals (so your main.tf can use local.web_base_port etc.)
  web_base_port = local.cfg.web_base_port
  app_base_port = local.cfg.app_base_port


common_labels = {
    env     = terraform.workspace
    project = "docker-terraform"
    owner   = "ariel"
  }

  # Tier-specific labels (merged with common)
  web_labels = merge(local.common_labels, { tier = "web" })
  app_labels = merge(local.common_labels, { tier = "app" })
  db_labels  = merge(local.common_labels, { tier = "db" })

  # ---- Computed names (DRY) ----
  network_name = "web-net-${terraform.workspace}"
  web_name     = "${terraform.workspace}-nginx"
  app_name     = "${terraform.workspace}-py-app"
  db_name      = "${terraform.workspace}-mysql-db"

  # ---- Computed port mappings from base ports ----
  # These are input LISTS -> perfect for your dynamic "ports" blocks in modules.
  web_port_mappings = [
    {
      internal = 80
      external = local.cfg.web_base_port
      protocol = "tcp"
    }
  ]

  app_port_mappings = [
    {
      internal = 8080
      external = local.cfg.app_base_port
      protocol = "tcp"
    }
  ]
}