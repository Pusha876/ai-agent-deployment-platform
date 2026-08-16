variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "AI Agent DEV resource group"
  type        = string
  default     = "rg-aiagent-dev-eastus"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "log_analytics_workspace_name" {
  description = "DEV Log Analytics workspace name"
  type        = string
  default     = "law-aiagent-dev-eastus"
}
