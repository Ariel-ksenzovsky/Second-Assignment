output "container_name" {
  description = "Primary MySQL container name"
  value       = docker_container.mysql.name
}

output "hostname" {
  description = "Hostname to use from app containers"
  value       = docker_container.mysql.name
}

output "primary_volume_name" {
  description = "Primary MySQL volume name"
  value       = docker_volume.mysql_data.name
}

output "replica_hostnames" {
  description = "Replica container hostnames"
  value       = [for c in docker_container.mysql_replica : c.name]
}

output "replica_volume_names" {
  description = "Replica volume names"
  value       = [for v in docker_volume.mysql_replica_data : v.name]
}
