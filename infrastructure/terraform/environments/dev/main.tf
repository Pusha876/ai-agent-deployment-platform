# AI Agent Platform - DEV
#
# Azure infrastructure will be added here
# as reusable Terraform modules are introduced.
module "monitoring" {
  source = "../../modules/monitoring"

  name                = var.log_analytics_workspace_name
  resource_group_name = var.agent_resource_group
  location            = var.location
  retention_days      = 30
}
