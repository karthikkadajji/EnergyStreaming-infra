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