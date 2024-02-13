# Deploying GCP resources with Terraform

The system infraestructure gets deployed using Terraform as a IaC tool.

# Compatibility

The deployment were tested using Terraform v1.7.3

# Pre-requisites

Bellow is the pre-requisites to deploy the infrastructure:

* Have Terraform installed
* Have a GCP project and the required IAM permissions to create the resources
* Have a GCS bucket to store the Terraform state data

# Steps to deploy the infrastructure

1. Change the files [main.tf](../src/terraform/main.tf) and [provider.tf](../src/terraform/provider.tf) with the project and region
2. Change the file [backend.tf](../src/terraform/backend.tf) with a bucket of GCS to store the state data
3. Authenticate with Google Cloud
4. Inside the [terraform](../src/terraform/) folder, run the commands bellow:

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```