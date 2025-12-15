output "container_names" {
  description = "Names of the created app containers"
  value       = docker_container.app[*].name
}

output "host_ports" {
  description = "External ports exposed on the host"
  value       = [
    for c in docker_container.app : c.ports[0].external
  ]
}

output "container_ips" {
  description = "IP addresses of the containers in the Docker network"
  value       = [
    for c in docker_container.app : c.network_data[0].ip_address
  ]
}
