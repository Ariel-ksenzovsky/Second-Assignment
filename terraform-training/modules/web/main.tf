# Pull Nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create multiple Nginx containers
resource "docker_container" "nginx" {
  count = var.instance_count

  name  = "nginx-${terraform.workspace}-${count.index}"
  image = docker_image.nginx.image_id

  # Expose unique host ports: base_port + index
  ports {
    internal = 80
    external = var.web_base_port + count.index
  }
networks_advanced {
  name = var.network_name
}

}

