variable "app_image" {
  description = "Docker image for the Flask app"
  type        = string
  default     = "arielk2511/docker-terraform-training:git-1ca342edcbd70042989cdaa1d96d9db0dd9263cf"
}

variable "nginx_image" {
  description = "Docker image for nginx"
  type        = string
  default     = "nginx:latest"
}

variable "db_name" {
  description = "MySQL database name"
  type        = string
  default     = "mydb"
}

variable "db_user" {
  description = "MySQL user"
  type        = string
  default     = "sqladminuser"
}

variable "db_password" {
  description = "MySQL password"
  type        = string
  sensitive   = true
  default     = "StrongSqlAdminPass123!"
}

variable "root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
  default     = "StrongSqlAdminPass123!"
}

variable "network_name" {
  type = string
  default = "net"
}