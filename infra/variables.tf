variable "region" {
  type        = string
  description = "region de despliegue"
}

variable "prefix_name" {
  type        = string
  description = "prefijo para nombres de recursos"
}

variable "user" {
  type        = string
  description = "usuario ssh"
}

variable "password" {
  type        = string
  description = "password ssh"
}
