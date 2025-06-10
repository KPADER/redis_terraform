locals {
  redis_id = var.create_redis ? azurerm_redis_cache.redis_cache[0].id : data.azurerm_redis_cache.redis_cache[0].id
  final_update_redis = var.create_redis ? false : var.update_redis
}

# Resource to create an Azure Redis Cache instance only if
# create_redis flag is true.
resource "azurerm_redis_cache" "redis_cache" {
  count                         = var.create_redis ? 1 : 0
  # Ensure the resource is created only if create_redis is true
  name                          = var.redis_name
  location                      = "West Europe"
  resource_group_name           = var.resource_group_name
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  redis_version                 = 6
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  redis_configuration {
    active_directory_authentication_enabled = true
  }
}

# Get a specific user-assigned managed identity Principle ID
data "azurerm_user_assigned_identity" "existing_uai" {
  name                = var.create_redis ? "umi-dws-${var.env}-${var.namespace}" : "umi-dws-${var.env}-data-platform-shared"
  resource_group_name = var.create_redis ? "rg-data-ws-${var.env}-${var.namespace}" : "rg-data-ws-${var.env}-data-platform-shared"
}

# Get existing redis cache info if flag is false
data "azurerm_redis_cache" "redis_cache" {
  count               = var.create_redis ? 0 : 1
  name                = "data-platform-shared-${var.env}-redis"
  resource_group_name = "rg-data-ws-${var.env}-data-platform-shared"
}

# # Create cache access policy
# resource "azurerm_redis_cache_access_policy" "custom_policy" {
#   count          = var.create_redis ? 1 : 0
#   name           = "${var.namespace}-policy"
#   redis_cache_id = var.create_redis ? azurerm_redis_cache.redis_cache[0].id : data.azurerm_redis_cache.redis_cache[0].id
#   # Use the created Redis Cache ID if create_redis is true, otherwise use the data source ID
#   permissions    = "+@read +get ~${var.namespace}-*"
# }

# Attach the created policy to redis cache
resource "azurerm_redis_cache_access_policy_assignment" "policy_assignment" {
  count               = var.create_redis ? 1 : 0
  name               = "${var.namespace}-policy-assignment"
  redis_cache_id     = var.create_redis ? azurerm_redis_cache.redis_cache[0].id : data.azurerm_redis_cache.redis_cache[0].id
  access_policy_name = "Data Owner"
  object_id          = data.azurerm_user_assigned_identity.existing_uai.principal_id
  object_id_alias    = "AccessPolicyAssignment"

  timeouts {
    create = "20m"
  }
}


# Update existing User Redis with new access policies if update_redis flag is true

data "azurerm_user_assigned_identity" "namespace_umi" {
  for_each            = local.final_update_redis ? toset(var.allowed_namespaces) : []
  name                = "umi-dws-${var.env}-${each.key}"
  resource_group_name = "rg-data-ws-${var.env}-${each.key}"
}

resource "azurerm_redis_cache_access_policy" "allowed_namespace_policy" {
  for_each            = local.final_update_redis ? toset(var.allowed_namespaces) : []
  name                = "${each.key}-policy"
  redis_cache_id      = local.redis_id
  permissions         = "+@read +get ~${each.key}-*"
}


resource "azurerm_redis_cache_access_policy_assignment" "allowed_namespace_assignment" {
  for_each           = local.final_update_redis ? toset(var.allowed_namespaces) : []
  name               = "${each.key}-policy-assignment"
  redis_cache_id     = local.redis_id
  access_policy_name = azurerm_redis_cache_access_policy.allowed_namespace_policy[each.key].name
  object_id          = data.azurerm_user_assigned_identity.namespace_umi[each.key].principal_id
  object_id_alias    = "AccessPolicyAssignment-${each.key}"

  timeouts {
    create = "20m"
  }
}