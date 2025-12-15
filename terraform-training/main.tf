
module "python_app" {  # app module
  source = "./modules/app"

  name            = "py-app"
  image           = "arielk2511/docker-terraform-training:3"
  instance_count  = 1
  network_name    = "web-net"  # same network as node_app

  env = {
  db_host            = module.mysql.internal_ip # Output from the DB module
  db_name            = "mysql-db"
  db_user            = "sqladminuser"
  db_password        = "StrongSqlAdminPass123!"
  }

  healthcheck_enabled = true
  healthcheck_test    = ["CMD-SHELL", "curl -f http://localhost:8000/health || exit 1"]
}


# Nginx cluster module (web)
module "nginx_cluster" {
  source = "./modules/web"

  instance_count = 2          # how many nginx containers
  base_port      = var.base_port       # 8080, 8081, ...
  network_name   = "web-net"  # shared network
}

# MySQL module
module "mysql" {
  internal_ip = module.mysql.internal_ip
  source = "./modules/mysql"
  name = "mysql-db"
  network_name = "web-net"
  db_password = "rootpassword"
  db_user = "root"
  db_name = "stargifs"
  root_password = ""

}
