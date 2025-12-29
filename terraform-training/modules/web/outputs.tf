output "container_names" {
  value = docker_container.nginx[*].name
}

output "host_ports" {
  value = [
    for c in docker_container.nginx : length(c.ports) > 0 ? c.ports[0].external : null
  ]
}
