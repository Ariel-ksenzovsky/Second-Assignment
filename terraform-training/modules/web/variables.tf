variable "instance_count" {
  description = "Number of Nginx containers to run"
  type        = number
  default     = 1
}

variable "base_port" {
  description = "Base external port on the host"
  type        = number
  default     = 5000
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