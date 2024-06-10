resource "azurerm_virtual_network" "VNET" {
    for_each = var.vnet
name = each.value.v_name
location = each.value.location
resource_group_name = each.value.resource_group_name
address_space = each.value.address_space
  
}
