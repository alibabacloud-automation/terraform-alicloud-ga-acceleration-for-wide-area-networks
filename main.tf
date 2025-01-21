resource "alicloud_ga_accelerator" "this" {
  accelerator_name       = var.ga_accelerator.accelerator_name
  description            = var.ga_accelerator.description
  duration               = var.ga_accelerator.duration
  auto_use_coupon        = var.ga_accelerator.auto_use_coupon
  spec                   = var.ga_accelerator.spec
  pricing_cycle          = var.ga_accelerator.pricing_cycle
  renewal_status         = var.ga_accelerator.renewal_status
  payment_type           = var.ga_accelerator.payment_type
  bandwidth_billing_type = var.ga_accelerator.bandwidth_billing_type
}

resource "alicloud_ga_bandwidth_package" "basic" {
  bandwidth      = var.bandwidth_package_basic.bandwidth
  type           = "Basic"
  bandwidth_type = var.bandwidth_package_basic.bandwidth_type
  duration       = var.bandwidth_package_basic.duration
  auto_pay       = var.bandwidth_package_basic.auto_pay
}

resource "alicloud_ga_bandwidth_package" "cross_domain" {
  count = var.create_cross_domain_bandwidth_package ? 1 : 0

  bandwidth = var.bandwidth_package_cross_domain.bandwidth
  type      = "CrossDomain"
  duration  = var.bandwidth_package_cross_domain.duration
  auto_pay  = var.bandwidth_package_cross_domain.auto_pay
}

resource "alicloud_ga_bandwidth_package_attachment" "basic" {
  accelerator_id       = alicloud_ga_accelerator.this.id
  bandwidth_package_id = alicloud_ga_bandwidth_package.basic.id
}

resource "alicloud_ga_bandwidth_package_attachment" "cross_domain" {
  count = var.create_cross_domain_bandwidth_package ? 1 : 0

  accelerator_id       = alicloud_ga_accelerator.this.id
  bandwidth_package_id = one(alicloud_ga_bandwidth_package.cross_domain[*].id)
}

resource "alicloud_ga_endpoint_group" "this" {
  accelerator_id        = alicloud_ga_accelerator.this.id
  endpoint_group_region = var.ga_endpoint_group.endpoint_group_region
  description           = var.ga_endpoint_group.description
  endpoint_group_type   = var.ga_endpoint_group.endpoint_group_type

  dynamic "endpoint_configurations" {
    for_each = var.ga_endpoint_group.endpoint_configurations
    content {
      endpoint = endpoint_configurations.value.endpoint
      type     = endpoint_configurations.value.type
      weight   = endpoint_configurations.value.weight
    }
  }

  listener_id = alicloud_ga_listener.tcp_80.id
}


resource "alicloud_ga_listener" "tcp_80" {
  accelerator_id = alicloud_ga_bandwidth_package_attachment.basic.accelerator_id
  protocol       = "TCP"
  port_ranges {
    from_port = 80
    to_port   = 80
  }
}


resource "alicloud_ga_ip_set" "this" {
  for_each = var.ga_ip_sets

  accelerate_region_id = each.key
  bandwidth            = each.value.bandwidth
  ip_version           = each.value.ip_version
  accelerator_id       = alicloud_ga_bandwidth_package_attachment.basic.accelerator_id
}

