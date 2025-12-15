variable "name" {
  description = "Base name for MySQL resources"
  type        = string
}

variable "image" {
  description = "MySQL image to use"
  type        = string
  default     = "mysql:8.0"
}

variable "network_name" {
  description = "Docker network name to attach MySQL to"
  default = "web-net"
  type        = string
}

variable "db_name" {
  description = "MySQL database name"
  type        = string
}

variable "db_user" {
  description = "MySQL user name"
  type        = string
}

variable "db_password" {
  description = "MySQL user password"
  type        = string
  sensitive   = true
}

variable "root_password" {
  description = "MySQL root password"
  type        = string
  sensitive   = true
}

variable "internal_ip" {
  description = "internal IP address of the MySQL container"
  type        = string
}
