variable "resource_group_name" {
  description = "The name of the Azure resource group"
}

variable "resource_name" {
  description = "The name of the Azure resource for which to create Private Endpoint"
}

variable "resource_id" {
  description = "The ID of the Azure resource for which to create Private Endpoint"
}

variable "sub_resource_type" {
  description = "Azure resource type. Example, 'vault' for Azure Key Vault, 'blob' for Azure Blob Storage, 'dataFactory' for Data Factory "
}

variable "location" {
  description = "The Azure region where the Private Endpoint will be created"
}

variable "subnet_id" {
  description = "The ID of the subnet to which the Private Endpoint will be connected"
}

variable "subscription_id" {
  description = "The Azure subscription ID where the Redis resources will be created."
}