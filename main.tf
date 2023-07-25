resource "azurerm_resource_group" "energy_application_rg" {
  name     = var.application_rg
  location = var.location
}

resource "azurerm_eventhub_namespace" "energy_application_eventhub_namespace" {
  name                = var.eventhub_namespace_name
  location            = azurerm_resource_group.energy_application_rg.location
  resource_group_name = azurerm_resource_group.energy_application_rg.name
  sku                 = "Standard"  # Change to your desired SKU (Standard, Basic, etc.)
}

resource "azurerm_eventhub" "energy_application_eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.energy_application_eventhub_namespace.name
  resource_group_name = azurerm_resource_group.energy_application_rg.name
  partition_count     = 2  # Change to your desired number of partitions
  message_retention   = 0
}