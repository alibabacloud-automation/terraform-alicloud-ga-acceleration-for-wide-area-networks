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
  default = {
    accelerator_name = "tf-example"
    description      = "tf-example"
  }
}


variable "ga_ip_sets" {
  description = "Map of GA IP sets configurations. The key is the region id."
  type = map(object({
    bandwidth  = optional(number, 5)
    ip_version = optional(string, "IPV4")
  }))
  default = {
    "cn-shanghai" = {
      bandwidth  = 10
      ip_version = "IPv4"
    }
    "cn-beijing" = {
      bandwidth  = 5
      ip_version = "IPv4"
    }
    "cn-hangzhou" = {
      bandwidth  = 5
      ip_version = "IPv4"
    }
  }
}

