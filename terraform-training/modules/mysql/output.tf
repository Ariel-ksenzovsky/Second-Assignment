output "hostname" {
  description = "Use as DATABASE_HOST from app containers"
  value       = docker_container.mysql.name
}

output "container_name" {
  value = docker_container.mysql.name
}

output "volume_name" {
  value = docker_volume.mysql_data.name
}

output "network_name" {
  value = var.network_name
}

output "replica_hostnames" {
  value = [for c in docker_container.mysql_replica : c.name]
}