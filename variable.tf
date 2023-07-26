variable "location" {
  description = "The Azure Region in which all resources in this project should be created."
  default     = "westeurope"
}

variable "application_rg" {
  description = "The resource group for the streaming application and storage"
  default     = "energy-stream-rg"
}

variable "eventhub_namespace_name" {
  default = "energy-application-eh-ns"
}

variable "eventhub_name" {
  default = "energy-application-eventhub"
}

variable "data_factory_name" {
  description = "Name of the Azure Data Factory."
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  default = "energy_streaming_application"
}
