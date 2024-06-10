resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = each.value.rule_name
    priority                   = each.value.priority
    direction                  = each.value.direction
    access                     = each.value.access
    protocol                   = each.value.protocol
    source_port_range          = each.value.source_port_range   
    destination_port_range     =each.value.destination_port_range
    source_address_prefix      =each.value.source_address_prefix
    destination_address_prefix = each.value.destination_address_prefix
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_a" {
  for_each = var.nsg
  subnet_id                 = data.azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}