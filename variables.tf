variable "web_application_firewall_policies" {
  description = <<EOT
Map of web_application_firewall_policies, attributes below
Required:
    - location
    - name
    - resource_group_name
    - managed_rules (block):
        - exclusion (optional, block):
            - excluded_rule_set (optional, block):
                - rule_group (optional, block):
                    - excluded_rules (optional)
                    - rule_group_name (required)
                - type (optional)
                - version (optional)
            - match_variable (required)
            - selector (required)
            - selector_match_operator (required)
        - managed_rule_set (required, block):
            - rule_group_override (optional, block):
                - rule (optional, block):
                    - action (optional)
                    - enabled (optional)
                    - id (required)
                - rule_group_name (required)
            - type (optional)
            - version (required)
Optional:
    - tags
    - custom_rules (block):
        - action (required)
        - enabled (optional)
        - group_rate_limit_by (optional)
        - match_conditions (required, block):
            - match_values (optional)
            - match_variables (required, block):
                - selector (optional)
                - variable_name (required)
            - negation_condition (optional)
            - operator (required)
            - transforms (optional)
        - name (optional)
        - priority (required)
        - rate_limit_duration (optional)
        - rate_limit_threshold (optional)
        - rule_type (required)
    - policy_settings (block):
        - enabled (optional)
        - file_upload_enforcement (optional)
        - file_upload_limit_in_mb (optional)
        - js_challenge_cookie_expiration_in_minutes (optional)
        - log_scrubbing (optional, block):
            - enabled (optional)
            - rule (optional, block):
                - enabled (optional)
                - match_variable (required)
                - selector (optional)
                - selector_match_operator (optional)
        - max_request_body_size_in_kb (optional)
        - mode (optional)
        - request_body_check (optional)
        - request_body_enforcement (optional)
        - request_body_inspect_limit_in_kb (optional)
EOT

  type = map(object({
    location            = string
    name                = string
    resource_group_name = string
    tags                = optional(map(string))
    managed_rules = object({
      exclusion = optional(list(object({
        excluded_rule_set = optional(object({
          rule_group = optional(list(object({
            excluded_rules  = optional(list(string))
            rule_group_name = string
          })))
          type    = optional(string)
          version = optional(string)
        }))
        match_variable          = string
        selector                = string
        selector_match_operator = string
      })))
      managed_rule_set = list(object({
        rule_group_override = optional(list(object({
          rule = optional(list(object({
            action  = optional(string)
            enabled = optional(bool)
            id      = string
          })))
          rule_group_name = string
        })))
        type    = optional(string)
        version = string
      }))
    })
    custom_rules = optional(list(object({
      action              = string
      enabled             = optional(bool)
      group_rate_limit_by = optional(string)
      match_conditions = list(object({
        match_values = optional(list(string))
        match_variables = list(object({
          selector      = optional(string)
          variable_name = string
        }))
        negation_condition = optional(bool)
        operator           = string
        transforms         = optional(set(string))
      }))
      name                 = optional(string)
      priority             = number
      rate_limit_duration  = optional(string)
      rate_limit_threshold = optional(number)
      rule_type            = string
    })))
    policy_settings = optional(object({
      enabled                                   = optional(bool)
      file_upload_enforcement                   = optional(bool)
      file_upload_limit_in_mb                   = optional(number)
      js_challenge_cookie_expiration_in_minutes = optional(number)
      log_scrubbing = optional(object({
        enabled = optional(bool)
        rule = optional(list(object({
          enabled                 = optional(bool)
          match_variable          = string
          selector                = optional(string)
          selector_match_operator = optional(string)
        })))
      }))
      max_request_body_size_in_kb      = optional(number)
      mode                             = optional(string)
      request_body_check               = optional(bool)
      request_body_enforcement         = optional(bool)
      request_body_inspect_limit_in_kb = optional(number)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        length(v.managed_rules.managed_rule_set) >= 1
      )
    ])
    error_message = "Each managed_rule_set list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.custom_rules == null || alltrue([for item in v.custom_rules : (length(item.match_conditions) >= 1)])
      )
    ])
    error_message = "Each match_conditions list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.custom_rules == null || alltrue([for item in v.custom_rules : (alltrue([for item in item.match_conditions : (length(item.match_variables) >= 1)]))])
      )
    ])
    error_message = "Each match_variables list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        length(v.name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.custom_rules == null || alltrue([for item in v.custom_rules : (item.rate_limit_threshold == null || (item.rate_limit_threshold >= 1))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        alltrue([for item in v.managed_rules.managed_rule_set : (item.rule_group_override == null || alltrue([for item in item.rule_group_override : (item.rule == null || alltrue([for item in item.rule : (length(item.id) > 0)]))]))])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.policy_settings == null || (v.policy_settings.file_upload_limit_in_mb == null || (v.policy_settings.file_upload_limit_in_mb >= 1 && v.policy_settings.file_upload_limit_in_mb <= 4000))
      )
    ])
    error_message = "must be between 1 and 4000"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.policy_settings == null || (v.policy_settings.max_request_body_size_in_kb == null || (v.policy_settings.max_request_body_size_in_kb >= 8 && v.policy_settings.max_request_body_size_in_kb <= 2000))
      )
    ])
    error_message = "must be between 8 and 2000"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.policy_settings == null || (v.policy_settings.request_body_inspect_limit_in_kb == null || (v.policy_settings.request_body_inspect_limit_in_kb >= 0))
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.policy_settings == null || (v.policy_settings.js_challenge_cookie_expiration_in_minutes == null || (v.policy_settings.js_challenge_cookie_expiration_in_minutes >= 5 && v.policy_settings.js_challenge_cookie_expiration_in_minutes <= 1440))
      )
    ])
    error_message = "must be between 5 and 1440"
  }
  validation {
    condition = alltrue([
      for k, v in var.web_application_firewall_policies : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 25 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

