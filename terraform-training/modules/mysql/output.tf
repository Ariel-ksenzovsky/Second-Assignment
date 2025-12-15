# modules/mysql/outputs.tf

output "container_name" {
  description = "Name of the MySQL container"
  value       = docker_container.mysql.name
}

output "volume_name" {
  description = "Name of the Docker volume used for MySQL data"
  value       = docker_volume.mysql_data.name
}

output "internal_ip" {
  description = "Internal IP address of the MySQL container on the Docker network"
  value       = docker_container.mysql.network_data[0].ip_address
}
