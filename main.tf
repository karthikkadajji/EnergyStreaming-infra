resource "azurerm_resource_group" "energy_application_rg" {
  name     = var.application_rg
  location = var.location
}