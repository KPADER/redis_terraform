variable "location" {
    description = "The Azure region where the Redis resources will be created."
    type        = string
    default     = "West Europe"
  
}

variable "capacity" {
    description = "The capacity of the Redis Cache instance."
    type        = number
}

variable "family" {
    description = "The family of the Redis Cache instance."
    type        = string  
}

variable "env" {
    description = "The environment for which the Redis resources are being created (e.g., dev, prod)."
    type        = string
}

variable "sku_name" {
    description = "The SKU name for the Redis Cache instance."
    type        = string
}

variable "subscription_id" {
    description = "The Azure subscription ID where the Redis resources will be created."
    type        = string
}

variable "namespace" {
    description = "The namespace for the Redis access policy and assignment."
    type        = string
}

variable "subnet_id" {
    description = "The ID of the subnet where the Redis Cache instance will be deployed."
    type        = string
    default     = "/subscriptions/92a8e2ef-d294-4a3b-b0b4-a284e90d85a6/resourceGroups/rg-network-nonprod-001/providers/Microsoft.Network/virtualNetworks/vnet-weu-app-4134-nonprod-001/subnets/snet-weu-app-4134-nonprod-redisCache"
}

variable "create_redis" {
    description = "Flag to determine whether to create the Redis Cache instance."
    type        = bool
    default     = false
}

variable "update_redis" {
  description = "Flag to determine whether to update the shared Redis Cache instance with new access policies."
  type        = bool
  default     = true
}

variable "allowed_namespaces" {
  description = "List of allowed namespaces for the Redis access policy."
  type        = list(string)
  default     = []
}
