provider "azurerm" {
  features {}

  # Define your Azure Service Principal credentials here
  subscription_id = "Enter the Subscription ID here"
  client_id       = "Enter the Client ID here"
  client_secret   = "Enter the Client Secret here"
  tenant_id       = "Enter the Tenant ID here"
}

# Create a resource group
resource "azurerm_resource_group" "vm_rg" {
  name     = "devopsmolvi-vm-rg"
  location = "East ASIA"
}

# Create a virtual network
resource "azurerm_virtual_network" "vm_vnet" {
  name                = "devopsmolvi-vm-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
}

# Create a subnet
resource "azurerm_subnet" "vm_subnet" {
  name                 = "devopsmolvi-vm-subnet"
  resource_group_name  = azurerm_resource_group.vm_rg.name
  virtual_network_name = azurerm_virtual_network.vm_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a public IP address
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "devopsmolvi-vm-public-ip"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
  allocation_method   = "Static"
}

# Create a network interface
resource "azurerm_network_interface" "vm_nic" {
  name                = "devopsmolvi-vm-nic"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "devopsmolvi-vm-ipconfig"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Create a virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "devopsmolvi-linux-vm"
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]
  size           = "Standard_DS1_v2"
  admin_username = "devopsmolvi"

  admin_ssh_key {
    username   = "devopsmolvi"
    public_key = file("~/.ssh/id_rsa.pub") # Ensure you have an SSH key pair created
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Output the public IP of the VM
output "public_ip_address" {
  value = azurerm_public_ip.vm_public_ip.ip_address
}

####################################################################
#                 Terraform Remote                                 #
#               Backend Configuration                              #
####################################################################

# Create a resource group for backend storage account
resource "azurerm_resource_group" "backend_rg" {
  name     = "devopsmolvi-backend-rg"
  location = "East ASIA"
}

# Create a Storage Account for Terraform state
resource "azurerm_storage_account" "sa" {
  name                     = "devopsmolvistorage" # Must be globally unique
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Blob Container
resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
terraform {
  backend "azurerm" {
    resource_group_name  = "devopsmolvi-backend-rg"
    storage_account_name = "devopsmolvistorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
