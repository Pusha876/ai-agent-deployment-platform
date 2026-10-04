output "log_analytics_workspace_id" {
  description = "PROD Log Analytics workspace resource ID"
  value       = module.monitoring.workspace_id
}

output "log_analytics_workspace_name" {
  description = "PROD Log Analytics workspace name"
  value       = module.monitoring.workspace_name
}
