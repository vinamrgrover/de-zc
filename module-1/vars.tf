variable region_name {
  description = "Name of the region"
  type        = string
}
variable project_name {
  description = "Name of the google cloud project"
  type        = string
}
variable instance_name {
  description = "Name of the instance"
  type        = string
  default     = "de-zc"
}

variable machine_type {
  description = "Machine type for VM"
  type        = string
}

variable network_interface {
  description = "Network interface"
  type        = string
}
variable ssh_key {
  description = "SSH key (Public)"
  type        = string
}

variable ssh_user {
  description = "SSH user"
  type        = string
}