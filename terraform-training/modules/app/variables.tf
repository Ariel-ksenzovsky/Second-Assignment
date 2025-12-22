variable "name" {
  description = "Base name for the application containers"
  type        = string
  default     = "app"
}

variable "image" {
  description = "Docker image for the application (Node.js / Python)"
  type        = string
}

variable "instance_count" {
  description = "Number of application containers to run"
  type        = number
  default     = 1
}

variable "internal_port" {
  description = "Port the app listens on inside the container"
  type        = number
  default     = 8080
}

variable "network_names" {
  description = "List of Docker networks to attach this container to"
  type        = list(string)
  default     = []
}


variable "env" {
  description = "Environment variables for the app containers"
  type        = map(string)
  default     = {}
}

# Healthcheck settings
variable "healthcheck_enabled" {
  description = "Enable container healthcheck"
  type        = bool
  default     = true
}

variable "healthcheck_test" {
  description = "Healthcheck test command (Docker format: e.g. [\"CMD-SHELL\", \"curl -f http://localhost:3000/health || exit 1\"])"
  type        = list(string)
  default     = []
}

variable "healthcheck_interval" {
  description = "Time between health checks"
  type        = string
  default     = "30s"
}

variable "healthcheck_timeout" {
  description = "Timeout for a single healthcheck"
  type        = string
  default     = "5s"
}

variable "healthcheck_retries" {
  description = "Number of retries before marking container as unhealthy"
  type        = number
  default     = 3
}

variable "healthcheck_start_period" {
  description = "Startup grace period before health checks start"
  type        = string
  default     = "10s"
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



