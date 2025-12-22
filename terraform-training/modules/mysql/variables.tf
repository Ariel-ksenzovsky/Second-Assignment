variable "name" {
  description = "MySQL container name (also DNS hostname)"
  type        = string
  default     = "mysql-db"
}

variable "image" {
  description = "MySQL image"
  type        = string
  default     = "mysql:8.0"
}

variable "network_name" {
  description = "Docker network name (created in root)"
  type        = string
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_user" {
  type        = string
  description = "Database user"
}

variable "db_password" {
  type        = string
  description = "Database user password"
  sensitive   = true
}

variable "root_password" {
  type        = string
  description = "MySQL root password"
  sensitive   = true
}

variable "replica_count" {
  description = "How many additional MySQL containers to run (demo replicas; not real replication)"
  type        = number
  default     = 0
}