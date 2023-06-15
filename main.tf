locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
}
#------------------------------------------
# Virtual Networks
#------------------------------------------
data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
}

resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus.name
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = var.servicebus.sku
  capacity            = var.servicebus.capacity
  local_auth_enabled  = var.servicebus.local_auth_enabled
  zone_redundant      = var.servicebus.zone_redundant
  minimum_tls_version = var.servicebus.minimum_tls_version
  tags                = var.tags
}

resource "azurerm_servicebus_queue" "queue" {
  for_each              = var.attach_queue == true ? var.queue : {}
  name                  = each.value["name"]
  namespace_id          = azurerm_servicebus_namespace.servicebus.id
  enable_partitioning   = each.value["enable_partitioning"]
  max_size_in_megabytes = each.value["max_size_in_megabytes"]
  status                = each.value["status"]
  max_delivery_count    = each.value["max_delivery_count"]
  lock_duration         = each.value["lock_duration"]
  auto_delete_on_idle   = each.value["auto_delete_on_idle"]
}
