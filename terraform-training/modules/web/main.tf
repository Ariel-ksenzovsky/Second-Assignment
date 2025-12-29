resource "docker_image" "nginx" {
  name = var.image
}

resource "docker_container" "nginx" {
  count = var.enabled ? var.instance_count : 0

  name  = "${var.name}-${count.index}"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = var.network_name
  }

  dynamic "ports" {
    for_each = var.port_mappings
    content {
      internal = ports.value.internal
      external = ports.value.external + count.index
      protocol = ports.value.protocol
    }
  }

  dynamic "labels" {
    for_each = var.labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}
