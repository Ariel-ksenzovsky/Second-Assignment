variable "instance_count" {
  description = "Number of Nginx containers to run"
  type        = number
  default     = 1
}


variable "network_name" {
  description = "Docker network name"
  type        = string
  default     = "web-net"
}

variable "image" {
  description = "Docker image to run"
  type        = string
  default     = "nginx:latest"
}

variable "labels" {
  description = "Docker labels to attach to containers"
  type        = map(string)
  default     = {}
}

variable "port_mappings" {
  description = "List of port mappings"
  type = list(object({
    internal = number
    external = number
    protocol = optional(string, "tcp")
  }))
  default = []
}

variable "enabled" {
  description = "Whether to create resources in this module"
  type        = bool
  default     = true
}

variable "name" {
  description = "Base name for nginx containers"
  type        = string
  default     = "nginx"
}
