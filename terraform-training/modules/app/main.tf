# # Custom Docker network
# resource "docker_network" "app_net" {
#   name = var.network_name
# }

# App image (Node.js or Python image you built)
resource "docker_image" "app" {
  name = "arielk2511/docker-terraform-training:3"
}

# Multiple app containers
resource "docker_container" "app" {
  count = var.instance_count

  name  = "${var.name}-${count.index}"
  image = docker_image.app.image_id
  ports {
    internal = var.internal_port
    external = var.base_external_port + count.index
  }

  

  # Attach to custom network
  # networks_advanced {
  #   name = docker_network.app_net.name
  # }


env = concat(
    [
  "DATABASE_HOST=mysql_db", // Connect using the database container's name
  "DATABASE_USER=root",
  "DATABASE_PASSWORD=mysecretpassword",
  "DATABASE_NAME=mydb"
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
