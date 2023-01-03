resource "azurerm_resource_group" "example" {
  name     = "cdn-test-4"
  location = "east us"
}

resource "azurerm_storage_account" "sa" {
  name                     = "baldlasga"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "images1"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
  #container_access_type = "container"
  #container_access_type = "private"
}


resource "azurerm_cdn_profile" "cdn-profile" {
  name                = "cdn-profile-4"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard_Verizon"
  #sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "cdn-endpoint" {
  name                = "cdn-ednpoint-4"
  profile_name        = azurerm_cdn_profile.cdn-profile.name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  origin {
    name      = "images-document"
    host_name = "${azurerm_storage_account.sa.name}.blob.core.windows.net"
  }
}
