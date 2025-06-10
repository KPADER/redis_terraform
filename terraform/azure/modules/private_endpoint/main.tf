resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "pep-${var.resource_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  custom_network_interface_name = "nic-${var.resource_name}"
  private_service_connection {
    is_manual_connection           = false
    name                           = "${var.resource_name}-privateserviceconnection"
    private_connection_resource_id = var.resource_id
    subresource_names              = [var.sub_resource_type]
  }
  lifecycle {
    ignore_changes = [tags, private_dns_zone_group]
  }
}

# Outputs
output "private_endpoint_id" {
  value = azurerm_private_endpoint.private_endpoint.id
}
output "private_endpoint_name" {
  value = azurerm_private_endpoint.private_endpoint.name
}
output "custom_network_interface_name" {
  value = azurerm_private_endpoint.private_endpoint.custom_network_interface_name
}
output "private_service_connection_name" {
  value = azurerm_private_endpoint.private_endpoint.private_service_connection[0].name
}