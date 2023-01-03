resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "east us"
}

resource "azurerm_storage_account" "sa" {
  name                     = "balalaalala"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "container"
  #container_access_type = "private"
}
