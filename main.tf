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
  resource_group_name      = azurerm_resource_group.energy_application_rg.name
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
  source                = "./modules/datafactory"
  data_factory_name     = var.data_factory_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.energy_application_rg.name
  storage_account_id    = azurerm_storage_account.storage_account.name
  destination_container = var.destination_container
}

#functionapp test
resource "azurerm_resource_group" "example" {
  name     = "azure-functions-example-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "kktestdeletedfsodi"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = "azure-functions-example-sp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = false

  sku {
    tier = "Standard"
    size = "S1"
  }

  lifecycle {
    ignore_changes = [
      kind
    ]
  }
}

resource "azurerm_function_app" "fun_app" {
  name                       = "example-azure-kktestdeletedfsodi"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  os_type                    = "linux"
  version                    = "~4"
  #publish_content{
  #  source_uri = "https://github.com/<user>/<repo>/archive/<branch>.zip"
  #  type       = "zip"
  #}

  site_config {
    linux_fx_version          = "PYTHON|3.7"
    use_32_bit_worker_process = false
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"
  }
}
resource "azurerm_key_vault" "my_key_vault" {
  name                = "my-key-vault"
  location            = azurerm_resource_group.energy_application_rg.location
  resource_group_name = azurerm_resource_group.energy_application_rg.name

  sku_name  = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_access_policy" "function_app_policy" {
  key_vault_id       = azurerm_key_vault.my_key_vault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azurerm_function_app.fun_app.identity[0].principal_id
  secret_permissions = ["Get"]
}

data "azurerm_client_config" "current" {}


