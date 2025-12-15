terraform {
  required_version = ">= 1.6.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  # If you're running inside WSL / Linux:
    host = "npipe:////./pipe/docker_engine"
}

# Pull the image
resource "docker_image" "nginx" {
  name = var.docker_image
}

# Create a container
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.docker_container_name

  ports {
    internal = 80
    external = var.docker_port
  }
}
