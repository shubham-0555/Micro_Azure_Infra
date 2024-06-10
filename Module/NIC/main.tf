resource "azurerm_network_interface" "nic" {
  for_each = var.nic
  name = each.value.n_name
  resource_group_name = each.value.resource_group_name
  location = each.value.location
  

  ip_configuration {
    subnet_id = data.azurerm_subnet.subnet[each.key].id
    name = each.value.ip_name
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}