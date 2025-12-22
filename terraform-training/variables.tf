variable "nginx_instance_count" {
  description = "How many Nginx containers to run"
  type        = number
  default     = 1
}

variable "webbase_port" {
  description = "The first port of the web module"
  default = 5000
}
