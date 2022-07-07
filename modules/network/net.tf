resource "azurerm_virtual_network" "net" {
  name                = "tfvnet${var.prefix}"
  address_space       = "${var.vnet_address_space}"
  location            = "${var.region}"
  resource_group_name = "${var.resource_group}"
}

resource "azurerm_subnet" "fwnet" {
  name                 = "AzureFirewallSubnet${var.prefix}"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = "${var.subnet_firewall_address_space}"
}

resource "azurerm_subnet" "acinet" {
  name                 = "aci-subnet${var.prefix}"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = azurerm_virtual_network.net.name
  address_prefixes     = "${var.subnet_aci_address_space}"
}

