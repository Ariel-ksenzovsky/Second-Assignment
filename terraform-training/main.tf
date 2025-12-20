module "python_app" {
  source       = "./modules/app"
  network_name = docker_network.web.name

  name           = "py-app"
  image          = "arielk2511/docker-terraform-training:3"
  instance_count = 1

  env = {
    DATABASE_HOST     = module.mysql.hostname
    DATABASE_PORT     = "3306"
    DATABASE_USER     = "sqladminuser"
    DATABASE_PASSWORD = "StrongSqlAdminPass123!"
    DATABASE_NAME     = "mydb"
  }

  depends_on = [module.mysql]
}


resource "docker_network" "web" {
  name = "web-net"
}

# Nginx cluster module (web)
module "nginx_cluster" {
  source = "./modules/web"
  network_name = docker_network.web.name

  instance_count = 2          # how many nginx containers
  base_port      = var.base_port       # 8080, 8081, ... 
}

# MySQL module
module "mysql" {
  source       = "./modules/mysql"
  network_name = docker_network.web.name

  name          = "mysql-db"
  image         = "mysql:8.0"
  db_name       = "mydb"
  db_user       = "sqladminuser"
  db_password   = "StrongSqlAdminPass123!"
  root_password = "StrongSqlAdminPass123!"
}

