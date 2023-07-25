resource "azurerm_resource_group" "energy_application_rg" {
  name     = var.application_rg
  location = var.location
}

resource "azurerm_eventhub_namespace" "energy_application_eventhub_ns" {
  name                = var.eventhub_namespace_name
  location            = azurerm_resource_group.energy_application_rg.location
  resource_group_name = azurerm_resource_group.energy_application_rg.name
  sku                 = "Standard"
  timeouts {
    create = "10m"
    delete = "10m"
  }
}