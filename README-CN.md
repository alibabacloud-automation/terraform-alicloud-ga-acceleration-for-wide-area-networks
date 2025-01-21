Terraform module to build GA Acceleration for Wide Area Networks on Alibaba Cloud

terraform-alicloud-ga-acceleration-for-wide-area-networks
======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-ga-acceleration-for-wide-area-networks/blob/main/README.md) | 简体中文

在游戏、跨境办公、跨境电商、APP出海等广域网场景中，存在用户端（client）和服务端（server）跨地域、跨境等远距离访问。经常出现用户访问服务内容加载慢、内容加载不出来、卡顿等问题。本方案使用网络层加速解决方案，缩短客户端访问服务端的时延，提升用户的访问体验。

架构图:

![image](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-ga-acceleration-for-wide-area-networks/main/scripts/diagram-CN.png)


## 用法

```hcl
provider "alicloud" {
  region = "cn-guangzhou"
}

resource "alicloud_eip_address" "default" {
  count                = 2
  bandwidth            = "10"
  internet_charge_type = "PayByBandwidth"
  address_name         = "tf-example-${count.index + 1}"
}

module "complete" {
  source = "alibabacloud-automation/ga-acceleration-for-wide-area-networks/alicloud"

  ga_accelerator = {
    accelerator_name = "tf-example"
    description      = "tf-example"
  }

  ga_endpoint_group = {
    endpoint_group_region = "cn-guangzhou"
    description           = "tf-example"
    endpoint_configurations = [{
      endpoint = alicloud_eip_address.default[0].ip_address
      type     = "PublicIp"
      weight   = 20
      }, {
      endpoint = alicloud_eip_address.default[1].ip_address
      type     = "PublicIp"
      weight   = 20
    }]
  }

  ga_ip_sets = {
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
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-ga-acceleration-for-wide-area-networks/tree/main/examples/complete)

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

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ga_accelerator.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_accelerator) | resource |
| [alicloud_ga_bandwidth_package.basic](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_bandwidth_package) | resource |
| [alicloud_ga_bandwidth_package.cross_domain](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_bandwidth_package) | resource |
| [alicloud_ga_bandwidth_package_attachment.basic](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_bandwidth_package_attachment) | resource |
| [alicloud_ga_bandwidth_package_attachment.cross_domain](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_bandwidth_package_attachment) | resource |
| [alicloud_ga_endpoint_group.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_endpoint_group) | resource |
| [alicloud_ga_ip_set.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_ip_set) | resource |
| [alicloud_ga_listener.tcp_80](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ga_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bandwidth_package_basic"></a> [bandwidth\_package\_basic](#input\_bandwidth\_package\_basic) | Configuration object for the basic bandwidth package. | <pre>object({<br>    bandwidth      = optional(number, 20)<br>    bandwidth_type = optional(string, "Basic")<br>    duration       = optional(number, 1)<br>    auto_pay       = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_bandwidth_package_cross_domain"></a> [bandwidth\_package\_cross\_domain](#input\_bandwidth\_package\_cross\_domain) | Configuration object for the basic bandwidth package. | <pre>object({<br>    bandwidth = optional(number, 20)<br>    duration  = optional(number, 1)<br>    auto_pay  = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_create_cross_domain_bandwidth_package"></a> [create\_cross\_domain\_bandwidth\_package](#input\_create\_cross\_domain\_bandwidth\_package) | whether to create a cross-domain bandwidth package. | `bool` | `false` | no |
| <a name="input_ga_accelerator"></a> [ga\_accelerator](#input\_ga\_accelerator) | Configuration object for the GA accelerator. | <pre>object({<br>    accelerator_name       = optional(string, null)<br>    description            = optional(string, null)<br>    duration               = optional(number, 1)<br>    auto_use_coupon        = optional(bool, true)<br>    spec                   = optional(string, "3")<br>    pricing_cycle          = optional(string, "Month")<br>    renewal_status         = optional(string, "Normal")<br>    payment_type           = optional(string, null)<br>    bandwidth_billing_type = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_ga_endpoint_group"></a> [ga\_endpoint\_group](#input\_ga\_endpoint\_group) | Configuration object for the GA endpoint group. | <pre>object({<br>    endpoint_group_region = string<br>    description           = optional(string, null)<br>    endpoint_group_type   = optional(string, "default")<br>    endpoint_configurations = list(object({<br>      endpoint = string<br>      type     = string<br>      weight   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_ga_ip_sets"></a> [ga\_ip\_sets](#input\_ga\_ip\_sets) | Map of GA IP sets configurations. The key is the region id. | <pre>map(object({<br>    bandwidth  = optional(number, 5)<br>    ip_version = optional(string, "IPV4")<br>  }))</pre> | `{}` | no |

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

## 提交问题

如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

## 作者

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## 许可

MIT Licensed. See LICENSE for full details.

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
