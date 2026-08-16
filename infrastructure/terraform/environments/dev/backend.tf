terraform {
  backend "azurerm" {
    resource_group_name  = "rg-aiagent-tfstate-eastus"
    storage_account_name = "staaiagenttfeus001"
    container_name       = "tfstate"
    key                  = "ai-agent-platform/dev/terraform.tfstate"

    use_azuread_auth = true
  }
}
