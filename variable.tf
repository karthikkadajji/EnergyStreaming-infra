variable "location" {
  description = "The Azure Region in which all resources in this project should be created."
  default     = "westeurope"
}

variable "application_rg" {
  description = "The resource group for the streaming application and storage"
  default     = "energy-stream"
}

variable "eventhub_namespace_name" {
  default = "energy"
}

variable "eventhub_name" {
  default = "energy_streaming"
}