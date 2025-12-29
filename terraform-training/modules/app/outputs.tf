output "container_names" {
  value = docker_container.app[*].name
}

output "host_ports" {
  value = [
    for c in docker_container.app : length(c.ports) > 0 ? c.ports[0].external : null
  ]
}
