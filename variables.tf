variable "service_name" {
  description = "Name of service to be used in resource names"
}

variable "resource_id" {
  description = "The resource type and unique identifier string"
}

variable "min_scale_capacity" {
  description = "The min capacity of the scalable target"
  default     = 8
}

variable "max_scale_capacity" {
  description = "The max capacity of the scalable target"
  default     = 20
}

variable "scaling_adjustment_up" {
  description = "The number of members by which to scale"
  default     = 1
}

variable "scaling_cooldown_up" {
  description = "The amount of time before the next scaling activty starts"
  default     = 60
}

variable "scaling_adjustment_down" {
  description = "The number of members by which to scale"
  default     = -1
}

variable "scaling_cooldown_down" {
  description = "The amount of time before the next scaling activty starts"
  default     = 300
}
