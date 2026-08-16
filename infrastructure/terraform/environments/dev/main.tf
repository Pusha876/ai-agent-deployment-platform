# AI Agent Platform - DEV
#
# Azure infrastructure will be added here
# as reusable Terraform modules are introduced.
terraform {
  required_version = ">= 1.9.0"
}

module "dev" {
  source = "../.."

  azure_subscription_id = var.azure_subscription_id
}
