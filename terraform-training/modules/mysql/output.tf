output "hostname" {
  value = var.enabled ? docker_container.mysql[0].name : null
}

output "primary_volume_name" {
  value = var.enabled ? docker_volume.mysql_data[0].name : null
}

output "replica_hostnames" {
  value = [for c in docker_container.mysql_replica : c.name]
}
