resource "azurerm_subnet" "SNET" {
    for_each = var.snet
name = each.value.s_name
resource_group_name=each.value.resource_group_name
address_prefixes = each.value.address_prefixes
virtual_network_name = each.value.virtual_network_name
}
