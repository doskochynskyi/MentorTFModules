output "vnet_name" {
  value azurerm_virtual_network.net.net
}

output "fwnet"{
  value azurerm_subnet.fwnet.name
}

output "fwnet_id" {
  value azurerm_subnet.fwnet.id
}

output "acinet" {
  value azurerm_subnet.acinet.name
}

