resource "azurerm_public_ip" "natgw_publicip" {
  name                = "natgw-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw" {
  name                = "natgw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_pip_associate" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw_publicip.id
}

resource "azurerm_subnet_nat_gateway_association" "natgw_appsubnet_associate" {
  subnet_id      = azurerm_subnet.subnets[appsubnet].id 
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}