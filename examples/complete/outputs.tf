output "ga_accelerator_id" {
  description = "The ID of the GA accelerator."
  value       = module.complete.ga_accelerator_id
}

output "basic_bandwidth_package_id" {
  description = "The ID of the basic bandwidth package."
  value       = module.complete.basic_bandwidth_package_id
}

output "cross_domain_bandwidth_package_id" {
  description = "The ID of the cross-domain bandwidth package."
  value       = module.complete.cross_domain_bandwidth_package_id
}

output "endpoint_group_id" {
  description = "The ID of the GA endpoint group."
  value       = module.complete.endpoint_group_id
}

output "listener_id" {
  description = "The ID of the GA listener."
  value       = module.complete.listener_id
}

output "ga_ip_set_ids" {
  description = "The IDs of the GA IP sets."
  value       = module.complete.ga_ip_set_ids
}
