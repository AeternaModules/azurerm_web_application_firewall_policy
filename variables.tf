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
      exclusion = optional(object({
        excluded_rule_set = optional(object({
          rule_group = optional(object({
            excluded_rules  = optional(list(string))
            rule_group_name = string
          }))
          type    = optional(string) # Default: "OWASP"
          version = optional(string) # Default: "3.2"
        }))
        match_variable          = string
        selector                = string
        selector_match_operator = string
      }))
      managed_rule_set = object({
        rule_group_override = optional(object({
          rule = optional(object({
            action  = optional(string)
            enabled = optional(bool) # Default: false
            id      = string
          }))
          rule_group_name = string
        }))
        type    = optional(string) # Default: "OWASP"
        version = string
      })
    })
    custom_rules = optional(object({
      action              = string
      enabled             = optional(bool) # Default: true
      group_rate_limit_by = optional(string)
      match_conditions = object({
        match_values = optional(list(string))
        match_variables = object({
          selector      = optional(string)
          variable_name = string
        })
        negation_condition = optional(bool)
        operator           = string
        transforms         = optional(set(string))
      })
      name                 = optional(string)
      priority             = number
      rate_limit_duration  = optional(string)
      rate_limit_threshold = optional(number)
      rule_type            = string
    }))
    policy_settings = optional(object({
      enabled                                   = optional(bool) # Default: true
      file_upload_enforcement                   = optional(bool)
      file_upload_limit_in_mb                   = optional(number) # Default: 100
      js_challenge_cookie_expiration_in_minutes = optional(number) # Default: 30
      log_scrubbing = optional(object({
        enabled = optional(bool) # Default: true
        rule = optional(object({
          enabled                 = optional(bool) # Default: true
          match_variable          = string
          selector                = optional(string)
          selector_match_operator = optional(string) # Default: "Equals"
        }))
      }))
      max_request_body_size_in_kb      = optional(number) # Default: 128
      mode                             = optional(string) # Default: "Prevention"
      request_body_check               = optional(bool)   # Default: true
      request_body_enforcement         = optional(bool)   # Default: true
      request_body_inspect_limit_in_kb = optional(number) # Default: 128
    }))
  }))
}

