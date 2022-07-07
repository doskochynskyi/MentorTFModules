variable "region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
}

variable "resource_group" {
  description = "This is the resource group where resources will be deployed."
}

variable "prefix" {
  description = "This is the environment where your webapp is deployed. qa, prod, or dev"
  #default = "prod"
}

variable "vnet_address_space" {
  
  description = "This is the environment where your webapp is deployed. qa, prod, or dev"
  default = "192.168.0.0/16"
}

variable "subnet_firewall_address_space" {
  description = "This is the environment where your webapp is deployed. qa, prod, or dev"
  default = "192.168.171.0/24"
}

variable "subnet_aci_address_space" {
  description = "This is the environment where your webapp is deployed. qa, prod, or dev"
  default = "192.168.172.0/24"
}
