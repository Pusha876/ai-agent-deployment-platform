variable "name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the workspace will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region for the workspace"
  type        = string
}

variable "retention_days" {
  description = "Log retention period"
  type        = number
  default     = 30
}
