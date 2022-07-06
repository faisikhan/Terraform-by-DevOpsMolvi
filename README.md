# Terraform

First of all, follow this URL to install Google Cloud SDK: https://cloud.google.com/sdk/docs/install

Login to GCP on your server:

gcloud auth application-default login --no-launch-browser

Credentials will be saved to the following file:

/root/.config/gcloud/application_default_credentials.json

**Important Terraform Commands:**

terraform init

terraform plan

terraform fmt

terraform apply

terraform init --reconfigure  [If you did some changes in main.tf or added any additional file, and you want to reflect those changes]

==================================================

**terraform.tfstate** file stores the current state of your infrastructure components, on your local machine.
