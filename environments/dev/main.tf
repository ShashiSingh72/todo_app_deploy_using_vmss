module "rg" {
  source = "../../modules/resource_group"
  rgs = var.rgs

}

module "vnet" {
    depends_on = [ module.rg ]
  source = "../../modules/virtual_network"
  vnets  = var.vnets
  
}

module "subnet" {
    depends_on = [ module.vnet, module.rg ]
  source = "../../modules/subnet"
  subnets = var.subnets

}
module "storage_account" {
    depends_on = [ module.rg ]
    source = "../../modules/storage_account"
    stgs  = var.stgs
  
}

module "nsg" {
    depends_on = [ module.rg ]
    source = "../../modules/network_security_group"
    nsgs  = var.nsgs
  
}

module "network_interface" {
    depends_on = [ module.rg, module.subnet, module.nsg ]
  source = "../../modules/network_interface"
  nics  = var.nics
  
}

module "virtual_machine_scale_set" {
    depends_on = [ module.rg, module.network_interface , module.subnet, module.vnet ]
  source = "../../modules/virtual_machine_scale_set"
  vmsss = var.vmsss
  
}
module "public_ip" {
    depends_on = [ module.rg ]
    source = "../../modules/public_ip"
    pips  = var.pips
  
}

module "lb" {
  depends_on = [ module.public_ip, module.rg ]
  source = "../../modules/load_balancer"
  load_balancers = var.load_balancers
  
}

module "application_gateway" {
  depends_on = [ module.rg, module.public_ip, module.subnet]
  source = "../../modules/application_gateway"
  appgtws = var.appgtws

}