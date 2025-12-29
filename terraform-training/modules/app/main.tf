resource "docker_image" "app" {
  name = var.image
}

resource "docker_container" "app" {
  count = var.enabled ? var.instance_count : 0

  name  = "${var.name}-${count.index}"
  image = var.image

  dynamic "networks_advanced" {
    for_each = var.network_names
    content {
      name = networks_advanced.value
    }
  }

  dynamic "ports" {
    for_each = var.port_mappings
    content {
      internal = ports.value.internal
      external = ports.value.external + count.index
      protocol = ports.value.protocol
    }
  }

  env = [for k, v in var.env : "${k}=${v}"]

  dynamic "labels" {
    for_each = var.labels
    content {
      label = labels.key
      value = labels.value
    }
  }
}
