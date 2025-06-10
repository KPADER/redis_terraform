output "existing_redis_cache_id" {
  value = try(data.azurerm_redis_cache.redis_cache[0].id, null)
}

output "existing_redis_cache_name" {
  value = try(data.azurerm_redis_cache.redis_cache[0].name, null)
}

output "redis_cache_id" {
  value = try(azurerm_redis_cache.redis_cache[0].id, null)
}

output "redis_cache_name" {
  value = try(azurerm_redis_cache.redis_cache[0].name, null)
}

# output "redis_cache_access_policy_id" {
#   value = try(azurerm_redis_cache_access_policy.custom_policy[0].id, null)
# }