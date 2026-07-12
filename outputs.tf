output "web_application_firewall_policies_custom_rules" {
  description = "Map of custom_rules values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.custom_rules }
}
output "web_application_firewall_policies_http_listener_ids" {
  description = "Map of http_listener_ids values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.http_listener_ids }
}
output "web_application_firewall_policies_location" {
  description = "Map of location values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.location }
}
output "web_application_firewall_policies_managed_rules" {
  description = "Map of managed_rules values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.managed_rules }
}
output "web_application_firewall_policies_name" {
  description = "Map of name values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.name }
}
output "web_application_firewall_policies_path_based_rule_ids" {
  description = "Map of path_based_rule_ids values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.path_based_rule_ids }
}
output "web_application_firewall_policies_policy_settings" {
  description = "Map of policy_settings values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.policy_settings }
}
output "web_application_firewall_policies_resource_group_name" {
  description = "Map of resource_group_name values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.resource_group_name }
}
output "web_application_firewall_policies_tags" {
  description = "Map of tags values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.tags }
}

