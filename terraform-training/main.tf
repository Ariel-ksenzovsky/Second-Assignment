
data "docker_network" "net" {
  # unique network per workspace so dev/staging/prod can run together
  name = "web-net-${terraform.workspace}"
}

module "mysql" {
  source       = "git::https://github.com/Ariel-ksenzovsky/terraform-docker-modules.git//docker-mysql?ref=v1.0.0"
  network_name = data.docker_network.net.name

  enabled = true

  name          = local.db_name
  image         = "mysql:8.0"
  db_name       = var.db_name
  db_user       = var.db_user
  db_password   = var.db_password
  root_password = var.root_password

  replica_count = local.cfg.db_replicas

  labels = local.db_labels
}

module "python_app" {
  source = "git::https://github.com/Ariel-ksenzovsky/terraform-docker-modules.git//docker-app?ref=v1.0.0"

  enabled = true

  network_names = [data.docker_network.net.name]

  name           = local.app_name
  image          = var.app_image
  instance_count = local.cfg.app_count

  # dynamic port mappings list
  port_mappings = local.app_port_mappings

  env = {
    DATABASE_HOST     = module.mysql.hostname
    DATABASE_PORT     = "3306"
    DATABASE_USER     = var.db_user
    DATABASE_PASSWORD = var.db_password
    DATABASE_NAME     = var.db_name
  }

  labels = local.app_labels

  depends_on = [module.mysql]
}

module "nginx_cluster" {
  source       = "git::https://github.com/Ariel-ksenzovsky/terraform-docker-modules.git//docker-web?ref=v1.0.0"
  network_name = data.docker_network.net.name

  enabled = true

  name           = local.web_name
  image          = var.nginx_image
  instance_count = local.cfg.web_count
  labels         = local.web_labels
  port_mappings = local.web_port_mappings
}