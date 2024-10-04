# Azure CLI? 

In this tutorial, we'll:
1. Install Azure CLI
2. Create a Principal
3. Login to our Azure Portal using az login command

# How to install Azure CLI?

We can install Azure CLI using the following steps:

1. Update the system

`sudo apt-get update`

2. Install required packages
 
 `sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release`

3. Download and install the Microsoft signing key:

  `sudo mkdir -p /etc/apt/keyrings
  curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
  sudo chmod go+r /etc/apt/keyrings/microsoft.gpg`

4. Add the Azure CLI software repository:

`AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources`

5. Update repository information and install the azure-cli package:

`sudo apt-get update
sudo apt-get install azure-cli`

6. Login to Azure using the following command:

`az login'

# How to Create a Service Principal for Terraform?

Terraform will need permissions to manage resources in your Azure account. Create a service principal using Azure CLI:

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<YOUR_SUBSCRIPTION_ID>"

