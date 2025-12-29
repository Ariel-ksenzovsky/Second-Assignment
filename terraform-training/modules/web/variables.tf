variable "enabled" {
  type    = bool
  default = true
}

variable "name" {
  type    = string
  default = "nginx"
}

variable "image" {
  type    = string
  default = "nginx:latest"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "network_name" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "port_mappings" {
  type = list(object({
    internal = number
    external = number
    protocol = optional(string, "tcp")
  }))
  default = []
}
