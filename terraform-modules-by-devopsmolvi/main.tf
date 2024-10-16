provider "azurerm" {
  features {}

  # Define your Azure Service Principal credentials here
  subscription_id = "Your Subscription ID here"
  client_id       = "Client ID here"
  client_secret   = "Client Secret here"
  tenant_id       = "Tenant ID here"

}

module "vm1" {
  source              = "./infra/vm1"
  resource_group_name = "devopsmolvi-resource-group"
  location            = "East ASIA"
  vnet_name           = "devopsmolvi-vnet"
  subnet_name         = "devopsmolvi-subnet"
  vm_name             = "devopsmolvi1-vm"
  vm_size             = "Standard_B1s"
  admin_username      = "devopsmolvi"
  admin_password      = "Your VM Password Here"
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  image_version       = "latest"
  tags = {
    Environment = "Dev"
  }
}

module "vm2" {
  source              = "./infra/vm2"
  resource_group_name = "devopsmolvi-resource-group"
  location            = "East ASIA"
  vnet_name           = "devopsmolvi-vnet"
  subnet_name         = "devopsmolvi-subnet"
  vm_name             = "devopsmolvi2-vm"
  vm_size             = "Standard_B1s"
  admin_username      = "devopsmolvi"
  admin_password      = "Your VM Password Here"
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  image_version       = "latest"
  tags = {
    Environment = "Dev"
  }
}

module "vm3" {
  source              = "./infra/vm3"
  resource_group_name = "devopsmolvi-resource-group"
  location            = "East ASIA"
  vnet_name           = "devopsmolvi-vnet"
  subnet_name         = "devopsmolvi-subnet"
  vm_name             = "devopsmolvi3-vm"
  vm_size             = "Standard_B1s"
  admin_username      = "devopsmolvi"
  admin_password      = "Your VM Password Here"
  image_publisher     = "Canonical"
  image_offer         = "UbuntuServer"
  image_sku           = "18.04-LTS"
  image_version       = "latest"
  tags = {
    Environment = "Dev"
  }
}
module "storage" {
  source               = "./infra/storage"
  resource_group_name  = "devopsmolvi-resource-group"
  location             = "East ASIA"
  storage_account_name = "devopsmolvidatastorage"
  container_name       = "devopsmolvi"
}
