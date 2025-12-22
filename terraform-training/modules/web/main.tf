# Pull Nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create multiple Nginx containers
resource "docker_container" "nginx" {
  count = var.enabled ? var.instance_count : 0

  name  = "nginx-${terraform.workspace}-${count.index}"
  image = docker_image.nginx.image_id

  # Expose unique host ports: base_port + index
  dynamic "ports" {
  for_each = var.port_mappings
  content {
    internal = ports.value.internal
    external = ports.value.external + count.index
    protocol = ports.value.protocol
  }
}

networks_advanced {
  name = var.network_name
}

  dynamic "labels" {
  for_each = var.labels
  content {
    label = labels.key
    value = labels.value
  }
}


}

