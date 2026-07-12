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
          type    = optional(string) # Default: "OWASP"
          version = optional(string) # Default: "3.2"
        }))
        match_variable          = string
        selector                = string
        selector_match_operator = string
      })))
      managed_rule_set = list(object({
        rule_group_override = optional(list(object({
          rule = optional(list(object({
            action  = optional(string)
            enabled = optional(bool) # Default: false
            id      = string
          })))
          rule_group_name = string
        })))
        type    = optional(string) # Default: "OWASP"
        version = string
      }))
    })
    custom_rules = optional(list(object({
      action              = string
      enabled             = optional(bool) # Default: true
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
      enabled                                   = optional(bool) # Default: true
      file_upload_enforcement                   = optional(bool)
      file_upload_limit_in_mb                   = optional(number) # Default: 100
      js_challenge_cookie_expiration_in_minutes = optional(number) # Default: 30
      log_scrubbing = optional(object({
        enabled = optional(bool) # Default: true
        rule = optional(list(object({
          enabled                 = optional(bool) # Default: true
          match_variable          = string
          selector                = optional(string)
          selector_match_operator = optional(string) # Default: "Equals"
        })))
      }))
      max_request_body_size_in_kb      = optional(number) # Default: 128
      mode                             = optional(string) # Default: "Prevention"
      request_body_check               = optional(bool)   # Default: true
      request_body_enforcement         = optional(bool)   # Default: true
      request_body_inspect_limit_in_kb = optional(number) # Default: 128
    }))
  }))
  # --- Unconfirmed validation candidates, derived from azurerm_web_application_firewall_policy's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: location
  #   source:    location.EnhancedValidate: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: custom_rules.action
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: custom_rules.match_conditions.match_variables.variable_name
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: custom_rules.match_conditions.operator
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: custom_rules.match_conditions.transforms[*]
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: custom_rules.rule_type
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: custom_rules.rate_limit_duration
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: custom_rules.rate_limit_threshold
  #   condition: value >= 1
  #   message:   must be at least 1
  # path: custom_rules.group_rate_limit_by
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: managed_rules.exclusion.match_variable
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: managed_rules.exclusion.selector
  #   source:    validation.NoZeroValues(...) - no translation rule yet, add one
  # path: managed_rules.exclusion.selector_match_operator
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: managed_rules.exclusion.excluded_rule_set.type
  #   source:    validate.ValidateWebApplicationFirewallPolicyExclusionRuleSetType (unresolved: func ValidateWebApplicationFirewallPolicyExclusionRuleSetType not found in /home/dan/code/public/terraform-provider-azurerm/internal/services/network/validate)
  # path: managed_rules.exclusion.excluded_rule_set.version
  #   source:    validate.ValidateWebApplicationFirewallPolicyExclusionRuleSetVersion (unresolved: func ValidateWebApplicationFirewallPolicyExclusionRuleSetVersion not found in /home/dan/code/public/terraform-provider-azurerm/internal/services/network/validate)
  # path: managed_rules.exclusion.excluded_rule_set.rule_group.rule_group_name
  #   source:    validate.ValidateWebApplicationFirewallPolicyRuleGroupName (unresolved: func ValidateWebApplicationFirewallPolicyRuleGroupName not found in /home/dan/code/public/terraform-provider-azurerm/internal/services/network/validate)
  # path: managed_rules.managed_rule_set.type
  #   source:    validate.ValidateWebApplicationFirewallPolicyRuleSetType (unresolved: func ValidateWebApplicationFirewallPolicyRuleSetType not found in /home/dan/code/public/terraform-provider-azurerm/internal/services/network/validate)
  # path: managed_rules.managed_rule_set.version
  #   source:    validate.ValidateWebApplicationFirewallPolicyRuleSetVersion (unresolved: func ValidateWebApplicationFirewallPolicyRuleSetVersion not found in /home/dan/code/public/terraform-provider-azurerm/internal/services/network/validate)
  # path: managed_rules.managed_rule_set.rule_group_override.rule_group_name
  #   source:    validate.ValidateWebApplicationFirewallPolicyRuleGroupName (unresolved: func ValidateWebApplicationFirewallPolicyRuleGroupName not found in /home/dan/code/public/terraform-provider-azurerm/internal/services/network/validate)
  # path: managed_rules.managed_rule_set.rule_group_override.rule.id
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: managed_rules.managed_rule_set.rule_group_override.rule.action
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: policy_settings.mode
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: policy_settings.file_upload_limit_in_mb
  #   condition: value >= 1 && value <= 4000
  #   message:   must be between 1 and 4000
  # path: policy_settings.max_request_body_size_in_kb
  #   condition: value >= 8 && value <= 2000
  #   message:   must be between 8 and 2000
  # path: policy_settings.request_body_inspect_limit_in_kb
  #   condition: value >= 0
  #   message:   must be at least 0
  # path: policy_settings.js_challenge_cookie_expiration_in_minutes
  #   condition: value >= 5 && value <= 1440
  #   message:   must be between 5 and 1440
  # path: policy_settings.log_scrubbing.rule.match_variable
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: policy_settings.log_scrubbing.rule.selector_match_operator
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: tags
  #   condition: length(value) <= 50
  #   message:   [from tags.Validate: invalid when len(value) > 50]
  #   source:    [from tags.Validate: invalid when len(value) > 50]
  # path: tags
  #   condition: length(value) <= 512
  #   message:   [from tags.Validate: invalid when len(value) > 512]
  #   source:    [from tags.Validate: invalid when len(value) > 512]
  # path: tags
  #   source:    [from tags.Validate] err != nil
  # path: tags
  #   condition: length(value) <= 256
  #   message:   [from tags.Validate: invalid when len(value) > 256]
  #   source:    [from tags.Validate: invalid when len(value) > 256]
}

