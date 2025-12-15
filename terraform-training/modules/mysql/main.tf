# Create / reuse network
resource "docker_network" "mysql_net" {
  name = var.network_name
}

# Volume for data persistence
resource "docker_volume" "mysql_data" {
  name = "${var.name}-data"
}

# Pull image
resource "docker_image" "mysql" {
  name = var.image
}

# MySQL container
resource "docker_container" "mysql" {
  name  = var.name
  image = docker_image.mysql.image_id

  # Expose port 3306
  ports {
    internal = 1433
    external = 60000
  }

  # No ports -> not exposed to host, only internal network
  networks_advanced {
    name = docker_network.mysql_net.name
  }

  mounts {
    target = "/var/lib/mysql"
    source = docker_volume.mysql_data.name
    type   = "volume"
  }

  env = [
    "MYSQL_DATABASE=${var.db_name}",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}",
    "MYSQL_ROOT_PASSWORD=${var.root_password}",
  ]
}