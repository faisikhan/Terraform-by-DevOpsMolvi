# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "devopsmolvi-resources-rg"
  location = "East ASIA"
}

# Create a Storage Account
resource "azurerm_storage_account" "sa2" {
  name                     = "devopsdata2"    # Must be globally unique
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"              # Locally-redundant storage
}

# Create a Blob Container (Storage "Bucket")
resource "azurerm_storage_container" "blob_container" {
  name                  = "devopsdatacontainer"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"              # Can be 'private', 'blob', or 'container'
}

# Output the Blob Container URL (optional)
output "blob_container_url" {
  value = azurerm_storage_container.blob_container.id
}
