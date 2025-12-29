output "network_name" {
  value = data.docker_network.net.name
}

output "nginx_container_names" {
  value = module.nginx_cluster.container_names
}

output "nginx_host_ports" {
  value = module.nginx_cluster.host_ports
}

output "app_container_names" {
  value = module.python_app.container_names
}

output "app_host_ports" {
  value = module.python_app.host_ports
}

output "mysql_hostname" {
  value = module.mysql.hostname
}

output "mysql_primary_volume" {
  value = module.mysql.primary_volume_name
}

output "mysql_replica_hostnames" {
  value = module.mysql.replica_hostnames
}
