# Outputs will be added as infrastructure is introduced.

output "log_analytics_workspace_id" {
  description = "DEV Log Analytics workspace resource ID"
  value       = module.monitoring.workspace_id
}

output "log_analytics_workspace_name" {
  description = "DEV Log Analytics workspace name"
  value       = module.monitoring.workspace_name
}
