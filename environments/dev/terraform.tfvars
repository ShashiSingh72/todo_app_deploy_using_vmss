rgs = {
  "rg1" = {
    resource_group_name = "todo-rg-001"
    location            = "west europe"
    managed_by          = "dev-team"
    tags = {
      team    = "dev-team"
      project = "project1"
    }
  }
}

vnets = {
  "vnet1" = {
    vnet_name           = "todo-vnet-001"
    location            = "west europe"
    address_space       = ["10.0.0.0/16"]
    resource_group_name = "todo-rg-001"
    tags = {
      team    = "dev-team"
      project = "project1"
    }


  }
}

subnets = {
  subnet1 = {
    subnet_name          = "todo-subnet-001"
    resource_group_name  = "todo-rg-001"
    virtual_network_name = "todo-vnet-001"
    address_prefixes     = ["10.0.1.0/24"]
    service_endpoints    = ["Microsoft.Storage", "Microsoft.Sql"]
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
  gtwsubnet = {
    subnet_name          = "todo-gtwsubnet-001"
    resource_group_name  = "todo-rg-001"
    virtual_network_name = "todo-vnet-001"
    address_prefixes     = ["10.0.2.0/24"]
    service_endpoints    = ["Microsoft.Storage", "Microsoft.Sql"]
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
}

stgs = {
  stgdev001 = {
    storage_account_name     = "todostgdev363238921"
    resource_group_name      = "todo-rg-001"
    location                 = "west europe"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
    is_hns_enabled           = true
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }

}

nsgs = {
  dev-nsg = {
    name                = "todo-nsg-001"
    location            = "west europe"
    resource_group_name = "todo-rg-001"
    security_rules = {
      allow-ssh = {
        name                       = "allow-ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      deny-all-outbound = {
        name                       = "deny-all-outbound"
        priority                   = 200
        direction                  = "Outbound"
        access                     = "Deny"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
}

nics = {
  nic1 = {
    network_interface_name = "todo-nic-001"
    location               = "west europe"
    resource_group_name    = "todo-rg-001"
    vnet_name              = "todo-vnet-001"
    subnet_name            = "todo-subnet-001"
    ip_configuration = {
      ipconfig1 = {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    }
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
}

vmsss = {
  dev-vmss = {
    vmss_name           = "todo-vmss-001"
    location            = "west europe"
    resource_group_name = "todo-rg-001"

    vnet_name   = "todo-vnet-001"
    subnet_name = "todo-subnet-001"

    sku       = "Standard_D2ads_v6"
    instances = 2

    admin_username = "azureuser"
    admin_password = "Password@12345"

    disable_password_authentication = false

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    network_interface = {
      name    = "todo-nic-001"
      primary = true
      ip_configuration = {
        name = "ipconfig1"
      }
    }

    tags = {
      env     = "dev"
      project = "todo"
    }
  }
}

pips = {
  "pip1" = {
    public_ip_name      = "todo-pip-011"
    resource_group_name = "todo-rg-001"
    location            = "west europe"
    allocation_method   = "Static"
    tags = {
      env     = "dev"
      project = "todo"
    }
  }
  "gtwpip" = {
    public_ip_name      = "todo-gtwpip-011"
    resource_group_name = "todo-rg-001"
    location            = "west europe"
    allocation_method   = "Static"
    tags = {
      env     = "dev"
      project = "todo"
    }
  }
}

load_balancers = {
  "lb1" = {
    lb_name             = "todo-LoadBalancer-001"
    resource_group_name = "todo-rg-001"
    location            = "west europe"
    frontend_ip_configurations = {
      "feConfig1" = {
        frontend_ip_configuration_name = "todo-FrontEndConfig"
      }
    }
    lb_rule_name                   = "todo-LoadBalancerRule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "todo-FrontEndConfig"
    backend_address_pool_name      = "todo-BackendPool"
    lb_probe_name                  = "todo-HealthProbe"
    port                           = 80
    interval_in_seconds            = 15
    number_of_probes               = 2
    public_ip_name                 = "todo-pip-011"
  }
}

appgtws = {
  appgw1 = {
    appgtw_name         = "appgw-todo-001"
    location            = "west europe"
    resource_group_name = "todo-rg-001"
    subnet_name         = "todo-gtwsubnet-001"
    vnet_name           = "todo-vnet-001"
    public_ip_name      = "todo-gtwpip-011"
    skus = {
      sku1 = {
        sku_name = "Standard_v2"
        tier     = "Standard_v2"
        capacity = 2
      }
    }
    gateway_ip_configurations = {
      gwipconfig1 = {
        gateway_ip_configuration_name = "appGatewayIpConfig"
      }
    }
  }
}


bastion_hosts = {
  bastion1 = {
    bastion_name        = "todo-BastionHost1"
    location            = "west europe"
    resource_group_name = "todo-rg-001"
    vnet_name           = "todo-vnet-001"
    allocation_method   = "Static"
    sku                 = "Standard"
    bastion_subnet_name = "AzureBastionSubnet"
    address_prefixes    = ["10.0.3.0/24"]
    ip_configuration = [
      {
        ip_configuration_name = "bastionIpConfig1"
      }
    ]
} }


key_vaults = {
  kvdev001 = {
    key_vault_name              = "todo-kv-001"
    location                    = "west europe"
    resource_group_name         = "todo-rg-001"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    tags = {
      environment = "dev"
      project     = "project1"
    }
  }
}


workspaces = {
  workspace1 = {
    workspaces_name     = "log-analytics-workspace-1"
    location            = "west europe"
    resource_group_name = "todo-rg-001"
    sku                 = "PerGB2018"
    retention_in_days   = 30
    tags = {
      environment = "dev"
      project     = "project-1"
    }
  }

}

data_collection_rules = {
  "collection_rule1" = {
    data_collection_rule_name                = "todo-dcr"
    resource_group_name                      = "todo-rg-001"
    location                                 = "west europe"
    storage_account_name                     = "todostgdev363238921"
    log_analytics_workspace_name             = "log-analytics-workspace-1"
    virtual_machine_scale_set_name           = "todo-vmss-001"
    virtual_machine_scale_set_extension_name = "todo-vmss-extention"
  }
}
