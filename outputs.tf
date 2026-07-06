output "web_application_firewall_policies" {
  description = "All web_application_firewall_policy resources"
  value       = azurerm_web_application_firewall_policy.web_application_firewall_policies
}
output "web_application_firewall_policies_custom_rules" {
  description = "List of custom_rules values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.custom_rules]
}
output "web_application_firewall_policies_http_listener_ids" {
  description = "List of http_listener_ids values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.http_listener_ids]
}
output "web_application_firewall_policies_location" {
  description = "List of location values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.location]
}
output "web_application_firewall_policies_managed_rules" {
  description = "List of managed_rules values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.managed_rules]
}
output "web_application_firewall_policies_name" {
  description = "List of name values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.name]
}
output "web_application_firewall_policies_path_based_rule_ids" {
  description = "List of path_based_rule_ids values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.path_based_rule_ids]
}
output "web_application_firewall_policies_policy_settings" {
  description = "List of policy_settings values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.policy_settings]
}
output "web_application_firewall_policies_resource_group_name" {
  description = "List of resource_group_name values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.resource_group_name]
}
output "web_application_firewall_policies_tags" {
  description = "List of tags values across all web_application_firewall_policies"
  value       = [for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : v.tags]
}

