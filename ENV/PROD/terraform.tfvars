module_rg_vnet = {
  r1 = {
    location            = "southindia"
    v_name              = "vnetaaja1"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = "papa_rg"
  }
}

module_snet = {
  s1 = {
    s_name               = "frontsnet"
    resource_group_name  = "papa_rg"
    address_prefixes     = ["10.0.1.0/24"]
    virtual_network_name = "vnetaaja1"
  }
  s2 = {
    s_name               = "backsnet"
    resource_group_name  = "papa_rg"
    address_prefixes     = ["10.0.2.0/24"]
    virtual_network_name = "vnetaaja1"
  }
  s3 = {
    s_name               = "AzureBastionSubnet"
    resource_group_name  = "papa_rg"
    address_prefixes     = ["10.0.5.0/27"]
    virtual_network_name = "vnetaaja1"
  }

}

VM_combine = {
  v1 = {
    s_name                        = "frontsnet"
    resource_group_name           = "papa_rg"
    virtual_network_name          = "vnetaaja1"
    n_name                        = "frontnic"
    location                      = "southindia"
    ip_name                       = "internal1"
    private_ip_address_allocation = "Dynamic"
    name_key                      = "modulekeyvault"
    name_uname                    = "username"
    name_pass                     = "password"
    vm_name                       = "frontvm"
    size                          = "Standard_F2"
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"
    rule_name                     = "test1"
    priority                      = 100
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "Tcp"
    source_port_range             = "*"
    destination_port_range        = "*"
    source_address_prefix         = "*"
    destination_address_prefix    = "*"
    s_name                        = "frontsnet"
    nsg_name                      = "frontnsg"
  }


  v2 = {
    s_name                        = "backsnet"
    resource_group_name           = "papa_rg"
    virtual_network_name          = "vnetaaja1"
    n_name                        = "backnic"
    ip_name                       = "internal2"
    private_ip_address_allocation = "Dynamic"
    n_name                        = "backnic"
    name_key                      = "modulekeyvault"
    name_uname                    = "username"
    name_pass                     = "password"
    vm_name                       = "backvm"
    location                      = "southindia"
    size                          = "Standard_F2"
    caching                       = "ReadWrite"
    storage_account_type          = "Standard_LRS"
    publisher                     = "Canonical"
    offer                         = "0001-com-ubuntu-server-jammy"
    sku                           = "22_04-lts"
    version                       = "latest"
    nsg_name                      = "backnsg"
    rule_name                     = "test2"
    priority                      = 100
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "Tcp"
    source_port_range             = "*"
    destination_port_range        = "*"
    source_address_prefix         = "*"
    destination_address_prefix    = "*"
    s_name                        = "backsnet"

  }
}

lb_bs = {
  l1 = {
    s_name                    = "AzureBastionSubnet"
    resource_group_name       = "papa_rg"
    virtual_network_name      = "vnetaaja1"
    name_pip                  = "examplepip"
    location                  = "southindia"
    allocation_method         = "Static"
    sku                       = "Standard"
    name_bs                   = "bastionji"
    name_bip                  = "external"
    pip_name                  = "PublicIPForLB-1"
    allocation_method         = "Static"
    sku                       = "Standard"
    lb_name                   = "Lb1"
    fronednip_name            = "frentend_PublicIPAddress"
    backend_pool_name         = "BackEndAddressPool"
    lb_probe_name             = "ssh-running-probe"
    lb_rule_name              = "LBRule"
    protocol                  = "Tcp"
    frontend_ip_configuration = "frentend_PublicIPAddress"
    sku_type                  = "Standard"
    n_name1                   = "frontnic"
    n_name2                   = "backnic"
    ip_configuration_front    = "internal1"
    ip_configuration_back     = "internal2"
  }
}