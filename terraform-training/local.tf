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
