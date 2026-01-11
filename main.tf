resource "azurerm_web_application_firewall_policy" "web_application_firewall_policys" {
  for_each = var.web_application_firewall_policys

  location            = each.value.location
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  managed_rules {
    dynamic "exclusion" {
      for_each = each.value.managed_rules.exclusion != null ? [each.value.managed_rules.exclusion] : []
      content {
        dynamic "excluded_rule_set" {
          for_each = exclusion.value.excluded_rule_set != null ? [exclusion.value.excluded_rule_set] : []
          content {
            dynamic "rule_group" {
              for_each = excluded_rule_set.value.rule_group != null ? [excluded_rule_set.value.rule_group] : []
              content {
                excluded_rules  = rule_group.value.excluded_rules
                rule_group_name = rule_group.value.rule_group_name
              }
            }
            type    = excluded_rule_set.value.type
            version = excluded_rule_set.value.version
          }
        }
        match_variable          = exclusion.value.match_variable
        selector                = exclusion.value.selector
        selector_match_operator = exclusion.value.selector_match_operator
      }
    }
    managed_rule_set {
      dynamic "rule_group_override" {
        for_each = each.value.managed_rules.managed_rule_set.rule_group_override != null ? [each.value.managed_rules.managed_rule_set.rule_group_override] : []
        content {
          dynamic "rule" {
            for_each = rule_group_override.value.rule != null ? [rule_group_override.value.rule] : []
            content {
              action  = rule.value.action
              enabled = rule.value.enabled
              id      = rule.value.id
            }
          }
          rule_group_name = rule_group_override.value.rule_group_name
        }
      }
      type    = each.value.managed_rules.managed_rule_set.type
      version = each.value.managed_rules.managed_rule_set.version
    }
  }

  dynamic "custom_rules" {
    for_each = each.value.custom_rules != null ? [each.value.custom_rules] : []
    content {
      action              = custom_rules.value.action
      enabled             = custom_rules.value.enabled
      group_rate_limit_by = custom_rules.value.group_rate_limit_by
      match_conditions {
        match_values = custom_rules.value.match_conditions.match_values
        match_variables {
          selector      = custom_rules.value.match_conditions.match_variables.selector
          variable_name = custom_rules.value.match_conditions.match_variables.variable_name
        }
        negation_condition = custom_rules.value.match_conditions.negation_condition
        operator           = custom_rules.value.match_conditions.operator
        transforms         = custom_rules.value.match_conditions.transforms
      }
      name                 = custom_rules.value.name
      priority             = custom_rules.value.priority
      rate_limit_duration  = custom_rules.value.rate_limit_duration
      rate_limit_threshold = custom_rules.value.rate_limit_threshold
      rule_type            = custom_rules.value.rule_type
    }
  }

  dynamic "policy_settings" {
    for_each = each.value.policy_settings != null ? [each.value.policy_settings] : []
    content {
      enabled                                   = policy_settings.value.enabled
      file_upload_enforcement                   = policy_settings.value.file_upload_enforcement
      file_upload_limit_in_mb                   = policy_settings.value.file_upload_limit_in_mb
      js_challenge_cookie_expiration_in_minutes = policy_settings.value.js_challenge_cookie_expiration_in_minutes
      dynamic "log_scrubbing" {
        for_each = policy_settings.value.log_scrubbing != null ? [policy_settings.value.log_scrubbing] : []
        content {
          enabled = log_scrubbing.value.enabled
          dynamic "rule" {
            for_each = log_scrubbing.value.rule != null ? [log_scrubbing.value.rule] : []
            content {
              enabled                 = rule.value.enabled
              match_variable          = rule.value.match_variable
              selector                = rule.value.selector
              selector_match_operator = rule.value.selector_match_operator
            }
          }
        }
      }
      max_request_body_size_in_kb      = policy_settings.value.max_request_body_size_in_kb
      mode                             = policy_settings.value.mode
      request_body_check               = policy_settings.value.request_body_check
      request_body_enforcement         = policy_settings.value.request_body_enforcement
      request_body_inspect_limit_in_kb = policy_settings.value.request_body_inspect_limit_in_kb
    }
  }
}

