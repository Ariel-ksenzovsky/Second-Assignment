variable "docker_host" {
  type        = string
  default     = "unix:///var/run/docker.sock"
  description = "The host to connect to for Docker"
}

variable "docker_image" {
  type        = string
  default     = "nginx:latest"
  description = "The image to run"
}

variable "docker_container_name" {
  type        = string
  default     = "test-nginx"
  description = "The name of the container"
}

variable "docker_port" {
  type        = number
  default     = 8080
  description = "The port to expose"
}