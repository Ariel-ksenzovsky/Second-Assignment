module "python_app" {
  source       = "./modules/app"
  network_names =[
    docker_network.net.name
  ]
  
  name           = "py-app"
  image          = "arielk2511/docker-terraform-training:3"
  instance_count = local.cfg.app_count
  app_base_external_port = local.app_base_port

  env = {
    DATABASE_HOST     = module.mysql.hostname
    DATABASE_PORT     = "3306"
    DATABASE_USER     = "sqladminuser"
    DATABASE_PASSWORD = "StrongSqlAdminPass123!"
    DATABASE_NAME     = "mydb"
  }

  depends_on = [module.mysql]
}


resource "docker_network" "net" {
  name = local.docker_network
}

# Nginx cluster module (web)
module "nginx_cluster" {
  source = "./modules/web"
  network_name = docker_network.net.name

  instance_count = local.cfg.web_count
  web_base_port =   local.web_base_port
}

# MySQL module
module "mysql" {
  source       = "./modules/mysql"
  network_name = docker_network.net.name

  name          = "mysql-db"
  image         = "mysql:8.0"
  db_name       = "mydb"
  db_user       = "sqladminuser"
  db_password   = "StrongSqlAdminPass123!"
  root_password = "StrongSqlAdminPass123!"

  replica_count = local.cfg.db_replicas
}

