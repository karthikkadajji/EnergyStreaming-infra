terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0"
    }
  }

  # Update this block with the location of your terraform state
  backend "azurerm" {
    resource_group_name  = "infra-rg"
    storage_account_name = "terraformgithubstg"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Define any Azure resources to be created here. A simple resource group is shown here as a minimal example.
#resource "azurerm_resource_group" "rg-aks" {
#  name     = var.resource_group_name
#  location = var.location
#}

resource "azurerm_storage_account" "stgkarthikdp203" {
  name                     = var.resource_group_name
  resource_group_name      = "infra-rg"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled = true

  tags = {
    environment = "staging1"
  }
}