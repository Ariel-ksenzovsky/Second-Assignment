variable "enabled" {
  type    = bool
  default = true
}

variable "name" {
  type    = string
  default = "py-app"
}

variable "image" {
  type = string
  default = "arielk2511/docker-terraform-training:git-1ca342e"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "network_names" {
  type    = list(string)
  default = []
}

variable "env" {
  type    = map(string)
  default = {}
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
