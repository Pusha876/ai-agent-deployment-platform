variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "agent_resource_group" {
  description = "Azure resource group associated with the AI agent deployment."
  type        = string
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
