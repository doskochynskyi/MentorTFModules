resource "azurerm_public_ip" "net" {
  name                = "tfpipnginx"
  location            = "${var.region}"
  resource_group_name = "${var.resource_group}"
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_firewall" "net" {
  name                = "tffwnginx"
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  location            = "${var.region}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.network.fwnet_id
    public_ip_address_id = azurerm_public_ip.net.id
  }
}

resource "azurerm_firewall_nat_rule_collection" "net" {
  name                = "natnginx80"
  azure_firewall_name = azurerm_firewall.net.name
  resource_group_name = "${var.resource_group}"

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
  resource_group_name = "${var.resource_group}"
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


