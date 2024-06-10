data "azurerm_network_interface" "nic13" {
  for_each             = var.vm
  name                 = each.value.n_name
  resource_group_name  = each.value.resource_group_name
 
}


data "azurerm_key_vault" "keyvault" {

  name = "modulekeyvault"
  resource_group_name = "perdada"
  
}

data "azurerm_key_vault_secret" "username" {
  
  name = "username"
  key_vault_id = data.azurerm_key_vault.keyvault.id
  
}
data "azurerm_key_vault_secret" "password" {
   
  name = "password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
  
}