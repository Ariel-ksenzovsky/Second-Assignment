output "nginx_names" {
  value = module.nginx_cluster.container_names
}

output "nginx_ports" {
  value = module.nginx_cluster.host_ports
}

output "nginx_ips" {
  value = module.nginx_cluster.container_ips
}

output "nginx_cluster_ips" {
  description = "The final list/map of NGINX container IPs from the module"
  # Change the reference to match the module call name:
  value       = module.nginx_cluster.container_ips 
}

output "mysql_container_name" {
  value = module.mysql.container_name
}

output "mysql_volume_name" {
  value = module.mysql.volume_name
}

output "mysql_internal_ip" {
  value = module.mysql.internal_ip
}