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
  source = "../.."

  ga_accelerator = var.ga_accelerator

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

  ga_ip_sets = var.ga_ip_sets

}
