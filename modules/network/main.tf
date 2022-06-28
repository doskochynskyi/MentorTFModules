resource "azurerm_virtual_network" "net" {
  name                = "tfvnetnginx"
  address_space       = ["192.168.0.0/16"]
  location            = ${var.region}
  resource_group_name = ${var.resource_group}
}

resource "azurerm_subnet" "fwnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name = ${var.resource_group}
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = ["192.168.140.0/24"]
}

resource "azurerm_subnet" "acinet" {
  name                 = "aci-subnet"
  resource_group_name = ${var.resource_group}
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = ["192.168.141.0/24"]
}

/*
resource "azurerm_public_ip" "net" {
  name                = "tfpipnginx"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "net" {
  name                = "tffwnginx"
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.fwnet.id
    public_ip_address_id = azurerm_public_ip.net.id
  }
}

resource "azurerm_firewall_nat_rule_collection" "net" {
  name                = "natnginx80"
  azure_firewall_name = azurerm_firewall.net.name
  resource_group_name = data.azurerm_resource_group.rg.name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "rulednatnginx80"

    source_addresses = [
      "*"
    ]

    destination_ports = [
      "80"
    ]

    destination_addresses = [
      azurerm_public_ip.net.ip_address
    ]

    translated_port = 80

    translated_address = "192.168.141.4"

    protocols = [
      "TCP"
    ]
  }
}

resource "azurerm_firewall_network_rule_collection" "rulenginx80" {
  name                = "rulenginx80"
  azure_firewall_name = azurerm_firewall.net.name
  resource_group_name = data.azurerm_resource_group.rg.name
  priority            = 101
  action              = "Allow"
  rule {
    name                  = "specific-range-firewall-rules"
    source_addresses      = ["*"]
    destination_addresses = ["192.168.141.4"]
    destination_ports     = ["80"]
    protocols             = ["TCP"]
  }
}

*/
