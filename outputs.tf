output "web_application_firewall_policies_id" {
  description = "Map of id values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "web_application_firewall_policies_custom_rules" {
  description = "Map of custom_rules values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.custom_rules if v.custom_rules != null && length(v.custom_rules) > 0 }
}
output "web_application_firewall_policies_http_listener_ids" {
  description = "Map of http_listener_ids values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.http_listener_ids if v.http_listener_ids != null && length(v.http_listener_ids) > 0 }
}
output "web_application_firewall_policies_location" {
  description = "Map of location values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.location if v.location != null && length(v.location) > 0 }
}
output "web_application_firewall_policies_managed_rules" {
  description = "Map of managed_rules values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.managed_rules if v.managed_rules != null && length(v.managed_rules) > 0 }
}
output "web_application_firewall_policies_name" {
  description = "Map of name values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.name if v.name != null && length(v.name) > 0 }
}
output "web_application_firewall_policies_path_based_rule_ids" {
  description = "Map of path_based_rule_ids values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.path_based_rule_ids if v.path_based_rule_ids != null && length(v.path_based_rule_ids) > 0 }
}
output "web_application_firewall_policies_policy_settings" {
  description = "Map of policy_settings values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.policy_settings if v.policy_settings != null && length(v.policy_settings) > 0 }
}
output "web_application_firewall_policies_resource_group_name" {
  description = "Map of resource_group_name values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "web_application_firewall_policies_tags" {
  description = "Map of tags values across all web_application_firewall_policies, keyed the same as var.web_application_firewall_policies"
  value       = { for k, v in azurerm_web_application_firewall_policy.web_application_firewall_policies : k => v.tags if v.tags != null && length(v.tags) > 0 }
}

