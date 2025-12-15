output "docker_container_name" {
  value = docker_container.nginx.name
}

output "docker_container_port" {
  value = docker_container.nginx.ports[0].external
}

output "docker_container_id" {
  value = docker_container.nginx.id
}