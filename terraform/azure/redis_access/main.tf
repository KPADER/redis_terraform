# Module to create redis cache if create_redis flag is true, If false 
# just update the shared redis cache with new access policies
module "redis_cache" {
  source              = "../modules/redis_cache"
  create_redis        = var.create_redis
  update_redis        = var.update_redis
  redis_name          = "${var.namespace}-${var.env}-redis"
  location            = "West Europe"
  resource_group_name = "rg-data-ws-${var.env}-${var.namespace}"
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  redis_version       = 6
  env                 = var.env
  namespace           = var.namespace
  subscription_id     = var.subscription_id
  allowed_namespaces  = var.allowed_namespaces
}

# Create private endpoint for Azure Cache Instance
module "redis_cache_private_endpoint" {
  count               = var.create_redis ? 1 : 0
  source              = "../modules/private_endpoint"
  location            = "West Europe"
  resource_group_name = "rg-data-ws-${var.env}-${var.namespace}"
  resource_id         = module.redis_cache.redis_cache_id
  resource_name       = "${var.namespace}-${var.env}-redis"
  sub_resource_type   = "redisCache"
  subnet_id           = var.subnet_id
  subscription_id     = var.subscription_id
}
