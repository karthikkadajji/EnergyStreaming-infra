variable "location" {
  description = "The Azure Region in which all resources in this project should be created."
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group for this project."
}

variable "data_factory_name" {
  description = "Name of the Azure Data Factory."
}

variable "storage_account_id" {
  description = "ID of the Azure Storage Account to be used."
}

variable "data_factory_connection_string" {
  description = "Name of the Data Factory linked service connection string."
  default = "datafactory_linked_service_connection"
}

variable "destination_container" {
  description = "The destination container location."
}
