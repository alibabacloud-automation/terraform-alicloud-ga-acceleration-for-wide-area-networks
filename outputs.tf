output "ga_accelerator_id" {
  description = "The ID of the GA accelerator."
  value       = alicloud_ga_accelerator.this.id
}

output "basic_bandwidth_package_id" {
  description = "The ID of the basic bandwidth package."
  value       = alicloud_ga_bandwidth_package.basic.id
}

output "cross_domain_bandwidth_package_id" {
  description = "The ID of the cross-domain bandwidth package."
  value       = one(alicloud_ga_bandwidth_package.cross_domain[*].id)
}

output "endpoint_group_id" {
  description = "The ID of the GA endpoint group."
  value       = alicloud_ga_endpoint_group.this.id
}

output "listener_id" {
  description = "The ID of the GA listener."
  value       = alicloud_ga_listener.tcp_80.id
}

output "ga_ip_set_ids" {
  description = "The IDs of the GA IP sets."
  value       = { for name, ip_set in alicloud_ga_ip_set.this : name => ip_set.id }
}
