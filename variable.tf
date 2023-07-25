variable "location" {
  description = "The Azure Region in which all resources in this project should be created."
  default     = "westeurope"
}

variable "application_rg" {
  description = "The resource group for the streaming application and storage"
  default     = "energy-stream"
}

variable backend_resource_group_name {
  description = "The resource group of backend terraform"
  default     = "infra-rg"
}
variable backend_storage_account_name {
  description = "The storage accnt of backend terraform"

  default = "terraformgithubstg"
}

variable "backend_container_name" {
  description = "The containername backend terraform"
  default     = "tfstate"

}

variable "backend_key" {
  description = "The containername backend terraform"
  default     = "terraform.tfstate"
}
