resource "azurerm_public_ip" "pip1" {
    for_each = var.bs
  name                = each.value.name_pip
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "bhost" {
  depends_on = [ azurerm_public_ip.pip1 ]
    for_each = var.bs
  name                = each.value.name_bs
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.name_bip
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.pip1[each.key].id
  }
}