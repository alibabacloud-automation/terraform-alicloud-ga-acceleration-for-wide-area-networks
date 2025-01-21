
# Complete

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_eip_address.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/eip_address) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ga_accelerator"></a> [ga\_accelerator](#input\_ga\_accelerator) | Configuration object for the GA accelerator. | <pre>object({<br>    accelerator_name       = optional(string, null)<br>    description            = optional(string, null)<br>    duration               = optional(number, 1)<br>    auto_use_coupon        = optional(bool, true)<br>    spec                   = optional(string, "3")<br>    pricing_cycle          = optional(string, "Month")<br>    renewal_status         = optional(string, "Normal")<br>    payment_type           = optional(string, null)<br>    bandwidth_billing_type = optional(string, null)<br>  })</pre> | <pre>{<br>  "accelerator_name": "tf-example",<br>  "description": "tf-example"<br>}</pre> | no |
| <a name="input_ga_ip_sets"></a> [ga\_ip\_sets](#input\_ga\_ip\_sets) | Map of GA IP sets configurations. The key is the region id. | <pre>map(object({<br>    bandwidth  = optional(number, 5)<br>    ip_version = optional(string, "IPV4")<br>  }))</pre> | <pre>{<br>  "cn-beijing": {<br>    "bandwidth": 5,<br>    "ip_version": "IPv4"<br>  },<br>  "cn-hangzhou": {<br>    "bandwidth": 5,<br>    "ip_version": "IPv4"<br>  },<br>  "cn-shanghai": {<br>    "bandwidth": 10,<br>    "ip_version": "IPv4"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_basic_bandwidth_package_id"></a> [basic\_bandwidth\_package\_id](#output\_basic\_bandwidth\_package\_id) | The ID of the basic bandwidth package. |
| <a name="output_cross_domain_bandwidth_package_id"></a> [cross\_domain\_bandwidth\_package\_id](#output\_cross\_domain\_bandwidth\_package\_id) | The ID of the cross-domain bandwidth package. |
| <a name="output_endpoint_group_id"></a> [endpoint\_group\_id](#output\_endpoint\_group\_id) | The ID of the GA endpoint group. |
| <a name="output_ga_accelerator_id"></a> [ga\_accelerator\_id](#output\_ga\_accelerator\_id) | The ID of the GA accelerator. |
| <a name="output_ga_ip_set_ids"></a> [ga\_ip\_set\_ids](#output\_ga\_ip\_set\_ids) | The IDs of the GA IP sets. |
| <a name="output_listener_id"></a> [listener\_id](#output\_listener\_id) | The ID of the GA listener. |
<!-- END_TF_DOCS -->