variable "enabled" {
  type    = bool
  default = true
}

variable "name" {
  type    = string
  default = "mysql-db"
}

variable "image" {
  type    = string
  default = "mysql:8.0"
}

variable "network_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "root_password" {
  type      = string
  sensitive = true
}

variable "replica_count" {
  type    = number
  default = 0
}

variable "labels" {
  type    = map(string)
  default = {}
}
