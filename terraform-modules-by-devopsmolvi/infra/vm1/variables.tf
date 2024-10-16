variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East ASIA"
}

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
