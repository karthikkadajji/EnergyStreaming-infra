
# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
resource "azurerm_resource_group" "example" {
  name     = var.application_rg
  location = var.location
}

