# Terraform

**Terraform** is an open source infrastructure as a code tool to automatically build your infrastructure. 

First of all, follow this URL to install Google Cloud SDK: https://cloud.google.com/sdk/docs/install

Login to GCP on your server:

gcloud auth application-default login --no-launch-browser

Credentials will be saved to the following file:

/root/.config/gcloud/application_default_credentials.json

**Important Terraform Commands:**

terraform init    ==========>   Initializes your working directory for terraform. Your terraform files must be there.

![image](https://user-images.githubusercontent.com/21220549/196621224-a4b534c2-ea5f-4821-b3e5-b0602667766e.png)

terraform validate    ==========>   Checks if the configuration is valid.

![image](https://user-images.githubusercontent.com/21220549/196621416-6f988b34-838e-4790-81d7-41e33e7ba535.png)

terraform plan    ==========>   It generates an overview of how terraform will execute the plan. It does not actually build the infrastructure, simply shows a layout.

![image](https://user-images.githubusercontent.com/21220549/196630733-c21baa63-9818-456a-821b-47c7b71ee2f9.png)

terraform fmt    ==========>   Properly formats the terraform configuration file.

terraform apply    ==========>   Apply the changes and our infrastructure starts building.
![image](https://user-images.githubusercontent.com/21220549/196641655-c8342efa-f401-49a5-b51f-20a51f21f4e7.png)

terraform init --reconfigure  [If you did some changes in main.tf or added any additional file, and you want to reflect those changes]

==================================================

**terraform.tfstate** file stores the current state of your infrastructure components, on your local machine.
