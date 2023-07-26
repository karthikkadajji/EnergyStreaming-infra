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

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.energy_application_rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = {
    environment = "development"
  }
}

resource "azurerm_eventhub" "energy_application_eventhub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.energy_application_eventhub_ns.name
  resource_group_name = azurerm_resource_group.energy_application_rg.name
  partition_count     = 2
  message_retention   = 7
  depends_on          = [azurerm_eventhub_namespace.energy_application_eventhub_ns]
}

module "datafactory" {
  source               = "./modules/datafactory"
  data_factory_name      = var.data_factory_name
  location             = var.location
  resource_group_name   = azurerm_resource_group.energy_application_rg.name
  destination_container = "test"
  storage_account_id = azurerm_storage_account.storage_account.name
}
