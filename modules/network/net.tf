resource "azurerm_virtual_network" "net" {
  name                = "tfvnetnginx"
  address_space       = ["192.168.0.0/16"]
  location            = "${var.region}"
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_subnet" "fwnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = ["192.168.140.0/24"]
}

resource "azurerm_subnet" "acinet" {
  name                 = "aci-subnet"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = ["192.168.141.0/24"]
}

