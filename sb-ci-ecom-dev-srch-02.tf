module "test-service_bus" {
  source                = "git::https://xkmjl6xcuanap5betn3m43lagh5y6llpn6lq5bqfpaxep7cynvca@dev.azure.com/IRL-INFRA-DEVOPS/IRL-MODULES/_git/IRL-MODULES//azurerm_servicebus_namespace"
  create_resource_group = true
  resource_group_name   = "test-rg"
  location              = "centralindia"
  servicebus = {
    name               = "test-service_bus"
    sku                = "Basic"
    local_auth_enabled = true
    zone_redundant     = false
    attach_queue       = true
  }

  queue = {
    "queue1" = {
      name                  = "queue1
      enable_partitioning   = false
      max_size_in_megabytes = "1024"
      status                = "Active"
      max_delivery_count    = 3
      lock_duration         = "30"
    },
}
