variable "location" {
  description = "The Azure Region in which all resources in this project should be created."
  default     = "westeurope"
}

variable "application_rg" {
  description = "The resource group for the streaming application and storage"
  default     = "energy-stream-rg"
}

variable "eventhub_namespace_name" {
  description = "event hub namespace"
  default     = "energy-application-eh-ns"
}

variable "eventhub_name" {
  description = "Name of the Azure event hub."
  default     = "energy-application-eventhub"
}

variable "data_factory_name" {
  description = "Name of the Azure Data Factory."
  default     = "energy-data-factory"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  default     = "energystreamapplication"
}

variable "destination_container" {
  description = "name of the container"
  default     = "datafactory-energy"
}

variable "key_vault_name" {
  description = "Name of key vault"
  default     = "energy-poc-vault"
}