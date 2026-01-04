# --- Chain module outputs through root ---

output "nginx_basic" {
  description = "NGINX tier outputs"
  value = {
    names = module.nginx_cluster.container_names
    ports = module.nginx_cluster.host_ports
    ips   = module.nginx_cluster.container_ips
  }
}

output "app_basic" {
  description = "App tier outputs"
  value = {
    names = module.python_app.container_names
    ports = module.python_app.host_ports
    ips   = module.python_app.container_ips
  }
}

output "mysql_basic" {
  description = "MySQL tier outputs"
  value = {
    hostname            = module.mysql.hostname
    primary_volume_name = module.mysql.primary_volume_name
    replica_hostnames   = module.mysql.replica_hostnames
  }
}

output "automation_json" {
  description = "Single JSON payload for automation/scripts"
  value = jsonencode({
    workspace = terraform.workspace

    web = {
      names = module.nginx_cluster.container_names
      ports = module.nginx_cluster.host_ports
      ips   = module.nginx_cluster.container_ips
    }

    app = {
      names = module.python_app.container_names
      ports = module.python_app.host_ports
      ips   = module.python_app.container_ips
    }

    db = {
      hostname          = module.mysql.hostname
      replica_hostnames = module.mysql.replica_hostnames
    }
  })
}


output "db_credentials" {
  description = "Database credentials (sensitive)"
  value = {
    user     = module.mysql.db_user
    password = module.mysql.db_password
  }
  sensitive = true
}
