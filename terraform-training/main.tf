# Shared network per workspace (you already do this)
resource "docker_network" "net" {
  name = local.docker_network
}

# -------------------------
# MySQL (DB tier)
# -------------------------
module "mysql" {
  source       = "./modules/mysql"
  network_name = docker_network.net.name

  # ✅ workspace-aware name (recommended so you can run multiple workspaces together)
  name = "${terraform.workspace}-mysql-db"

  image         = "mysql:8.0"
  db_name       = "mydb"
  db_user       = "sqladminuser"
  db_password   = "StrongSqlAdminPass123!"
  root_password = "StrongSqlAdminPass123!"

  replica_count = local.cfg.db_replicas

  # ✅ dynamic labels (module must implement dynamic "labels" block)
  labels = {
    env  = terraform.workspace
    tier = "db"
  }

  # ✅ conditional creation (optional — only if you implement enabled in mysql module)
  enabled = true
}

# -------------------------
# Python app (APP tier)
# -------------------------
module "python_app" {
  source = "./modules/app"

  # ✅ dynamic networks (module must implement dynamic networks_advanced block)
  network_names = [
    docker_network.net.name
  ]

  # ✅ workspace-aware base name
  name           = "${terraform.workspace}-py-app"
  image          = "arielk2511/docker-terraform-training:3"
  instance_count = local.cfg.app_count

  # ✅ dynamic port mappings list (module must implement dynamic "ports" block)
  # This pattern gives each app container a unique host port:
  # app_base_external_port + index
  port_mappings = [
    {
      internal = 8080
      external = local.app_base_port
      protocol = "tcp"
    }
  ]

  # ✅ env stays same (but use mysql hostname output)
  env = {
    DATABASE_HOST     = module.mysql.hostname
    DATABASE_PORT     = "3306"
    DATABASE_USER     = "sqladminuser"
    DATABASE_PASSWORD = "StrongSqlAdminPass123!"
    DATABASE_NAME     = "mydb"
  }

  # ✅ dynamic labels
  labels = {
    env  = terraform.workspace
    tier = "app"
  }

  # ✅ conditional creation
  enabled = true

  depends_on = [module.mysql]
}

# -------------------------
# Nginx (WEB tier)
# -------------------------
module "nginx_cluster" {
  source       = "./modules/web"
  network_name = docker_network.net.name

  name           = "${terraform.workspace}-nginx"
  instance_count = local.cfg.web_count

  # ✅ dynamic port mappings list for web
  port_mappings = [
    {
      internal = 80
      external = local.web_base_port
      protocol = "tcp"
    }
  ]

  # ✅ dynamic labels
  labels = {
    env  = terraform.workspace
    tier = "web"
  }

  # ✅ conditional creation (example: disable nginx in dev if you want)
  enabled = true
}
