


# App image (Node.js or Python image you built)
resource "docker_image" "app" {
  name = "arielk2511/docker-terraform-training:latest"
}

# Multiple app containers
resource "docker_container" "app" {
  count = var.instance_count

  name  = "${var.name}-${workspace.name}-${count.index}"
  image = docker_image.app.image_id
  ports {
    internal = var.internal_port
    external = var.app_base_external_port + count.index
  }

 dynamic "networks_advanced" {
  for_each = var.network_names
  content {
    name = networks_advanced.value
  }
}


  # Attach to custom network
  # networks_advanced {
  #   name = docker_network.app_net.name
  # }


env = concat(
  [
    "DATABASE_HOST=${lookup(var.env, "DATABASE_HOST", "mysql-db")}",
    "DATABASE_PORT=${lookup(var.env, "DATABASE_PORT", "3306")}",
    "DATABASE_USER=${lookup(var.env, "DATABASE_USER", "sqladminuser")}",
    "DATABASE_PASSWORD=${lookup(var.env, "DATABASE_PASSWORD", "StrongSqlAdminPass123!")}",
    "DATABASE_NAME=${lookup(var.env, "DATABASE_NAME", "mydb")}"
  ],
  [
    for k, v in var.env : "${k}=${v}"
  ]
)

  
  # Healthcheck (only if enabled and test defined)
  dynamic "healthcheck" {
    for_each = var.healthcheck_enabled && length(var.healthcheck_test) > 0 ? [1] : []

    content {
      test         = var.healthcheck_test
      interval     = var.healthcheck_interval
      timeout      = var.healthcheck_timeout
      retries      = var.healthcheck_retries
      start_period = var.healthcheck_start_period
    }
  }
}
