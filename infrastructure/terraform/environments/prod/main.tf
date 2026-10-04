# AI Agent Platform - PROD

# The prod resource group was created outside Terraform; adopt it into state.
import {
  to = azurerm_resource_group.agent
  id = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.agent_resource_group}"
}

resource "azurerm_resource_group" "agent" {
  name     = var.agent_resource_group
  location = var.location
}

module "monitoring" {
  source = "../../modules/monitoring"

  name                = var.log_analytics_workspace_name
  resource_group_name = azurerm_resource_group.agent.name
  location            = var.location
  retention_days      = 30
}
