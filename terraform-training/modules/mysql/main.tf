resource "docker_image" "mysql" {
  name = var.image
}

# Primary volume (SINGLE — no count)
resource "docker_volume" "mysql_data" {
  name = "${var.name}-data"
}

# Primary MySQL container (SINGLE — no count)
resource "docker_container" "mysql" {
  name    = "${var.name}-${terraform.workspace}"
  image   = docker_image.mysql.image_id
  restart = "unless-stopped"

  networks_advanced {
    name = var.network_name
  }

  mounts {
    target = "/var/lib/mysql"
    source = docker_volume.mysql_data.name
    type   = "volume"
  }

  command = ["--bind-address=0.0.0.0", "--port=3306"]

  env = [
    "MYSQL_ROOT_PASSWORD=${var.root_password}",
    "MYSQL_DATABASE=${var.db_name}",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}",
  ]

  healthcheck {
    test     = ["CMD-SHELL", "mysqladmin ping -h 127.0.0.1 -uroot -p${var.root_password} --silent"]
    interval = "10s"
    timeout  = "5s"
    retries  = 12
  }

  dynamic "labels" {
  for_each = var.labels
  content {
    label = labels.key
    value = labels.value
  }
}


}

# Replica volumes (LIST — count)
resource "docker_volume" "mysql_replica_data" {
  count = var.replica_count
  name  = "${var.name}-data-replica-${count.index}"
}

# Replica containers (LIST — count)
resource "docker_container" "mysql_replica" {
  count   = var.replica_count
  name    = "${var.name}-replica-${count.index}"
  image   = docker_image.mysql.image_id
  restart = "unless-stopped"

  networks_advanced {
    name = var.network_name
  }

  mounts {
    target = "/var/lib/mysql"
    source = docker_volume.mysql_replica_data[count.index].name
    type   = "volume"
  }

  command = ["--bind-address=0.0.0.0", "--port=3306"]

  # NOTE: extra containers only (not real replication)
  env = [
    "MYSQL_ROOT_PASSWORD=${var.root_password}",
    "MYSQL_DATABASE=${var.db_name}",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}",
  ]

  dynamic "labels" {
  for_each = var.labels
  content {
    label = labels.key
    value = labels.value
  }
}

}
