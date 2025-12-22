# Names of the created containers
output "container_names" {
  description = "Names of the created Nginx containers"
  value       = docker_container.nginx[*].name
}

# Host ports mapped for each container (external ports)
output "host_ports" {
  description = "External ports mapped on the host"
  value       = [
    for c in docker_container.nginx : c.ports[0].external
  ]
}

# IPs of containers on the Docker network
output "container_ips" {
  description = "IP addresses of the containers in the Docker network"
  value       = [
    for c in docker_container.nginx : c.network_data[0].ip_address
  ]
}

