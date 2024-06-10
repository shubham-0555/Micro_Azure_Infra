module "rg" {
  source = "../../Module/RG"
  rg     = var.module_rg_vnet
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../Module/VNET"
  vnet       = var.module_rg_vnet
}

module "Subnet" {
  depends_on = [module.vnet]
  source     = "../../Module/SUBNET"
  snet       = var.module_snet
}

module "nsg" {
  depends_on = [module.Subnet]
  source     = "../../Module/NSG"
  nsg        = var.VM_combine
}

module "nic" {
  depends_on = [module.Subnet]
  source     = "../../Module/NIC"
  nic        = var.VM_combine
}

module "vm" {
  depends_on = [module.nic]
  source     = "../../Module/VM"
  vm         = var.VM_combine
}

module "bastion" {
  depends_on = [module.Subnet, ]
  source     = "../../Module/Bastion"
  bs         = var.lb_bs
}
module "lb" {
  depends_on = [module.nic, module.vm]
  source     = "../../Module/LB"
  lb         = var.lb_bs
}
