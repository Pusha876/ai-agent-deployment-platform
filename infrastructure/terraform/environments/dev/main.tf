# AI Agent Platform - DEV
#
# Azure infrastructure will be added here
# as reusable Terraform modules are introduced.
module "monitoring" {
  source = "../../modules/monitoring"

  name                = var.log_analytics_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  retention_days      = 30
}
