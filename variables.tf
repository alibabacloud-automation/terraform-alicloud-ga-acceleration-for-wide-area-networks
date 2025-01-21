variable "ga_accelerator" {
  description = "Configuration object for the GA accelerator."
  type = object({
    accelerator_name       = optional(string, null)
    description            = optional(string, null)
    duration               = optional(number, 1)
    auto_use_coupon        = optional(bool, true)
    spec                   = optional(string, "3")
    pricing_cycle          = optional(string, "Month")
    renewal_status         = optional(string, "Normal")
    payment_type           = optional(string, null)
    bandwidth_billing_type = optional(string, null)
  })
  default = {}
}

variable "bandwidth_package_basic" {
  description = "Configuration object for the basic bandwidth package."
  type = object({
    bandwidth      = optional(number, 20)
    bandwidth_type = optional(string, "Basic")
    duration       = optional(number, 1)
    auto_pay       = optional(bool, true)
  })
  default = {}
}

variable "create_cross_domain_bandwidth_package" {
  description = "whether to create a cross-domain bandwidth package."
  type        = bool
  default     = false
}


variable "bandwidth_package_cross_domain" {
  description = "Configuration object for the basic bandwidth package."
  type = object({
    bandwidth = optional(number, 20)
    duration  = optional(number, 1)
    auto_pay  = optional(bool, true)
  })
  default = {}
}


variable "ga_endpoint_group" {
  description = "Configuration object for the GA endpoint group."
  type = object({
    endpoint_group_region = string
    description           = optional(string, null)
    endpoint_group_type   = optional(string, "default")
    endpoint_configurations = list(object({
      endpoint = string
      type     = string
      weight   = number
    }))
  })
}


variable "ga_ip_sets" {
  description = "Map of GA IP sets configurations. The key is the region id."
  type = map(object({
    bandwidth  = optional(number, 5)
    ip_version = optional(string, "IPV4")
  }))
  default = {}
}

