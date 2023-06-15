module "sb-ci-ecom-dev-srch-02" {
  source                = "git::https://xkmjl6xcuanap5betn3m43lagh5y6llpn6lq5bqfpaxep7cynvca@dev.azure.com/IRL-INFRA-DEVOPS/IRL-MODULES/_git/IRL-MODULES//azurerm_servicebus_namespace"
  create_resource_group = true
  resource_group_name   = "rsg-ci-ecom-dev-srch-01"
  location              = "centralindia"
  servicebus = {
    name               = "sb-ci-ecom-dev-srch-02"
    sku                = "Basic"
    local_auth_enabled = true
    zone_redundant     = false
    attach_queue       = true
  }

  queue = {
    "queue1" = {
      name                  = "catalog-dev"
      enable_partitioning   = false
      max_size_in_megabytes = "1024"
      status                = "Active"
      max_delivery_count    = 3
      lock_duration         = "30"
    },
    "queue2" = {
      name                  = "catalog-pt"
      enable_partitioning   = false
      max_size_in_megabytes = "1024"
      status                = "Active"
      max_delivery_count    = 3
      lock_duration         = "30"
    },
    "queue3" = {
      name                  = "catalog-uat"
      enable_partitioning   = false
      max_size_in_megabytes = "1024"
      status                = "Active"
      max_delivery_count    = 3
      lock_duration         = "30"
    },
  }
}
