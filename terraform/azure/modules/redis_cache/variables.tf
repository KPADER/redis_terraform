variable "resource_group_name" {
    description = "The name of the resource group in which to create the Redis resources."
    type        = string
}

variable "redis_name" {
    description = "The name of the Azure Redis Cache instance."
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

variable "redis_version" {
    description = "The version of the Redis Cache instance."
    type        = string
    default     = "6"
}

variable "create_redis" {
    description = "Flag to create the Redis Cache instance."
    type        = bool
    default     = false
}

variable "update_redis" {
    description = "Flag to update the shared Redis Cache instance with new access policies."
    type        = bool
    default     = true
}

variable "allowed_access_to_namespaces" {
    description = "List of allowed namespaces for the Redis access policy."
    type        = list(string)
    default     = []
}
