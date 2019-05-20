# terraform-azure-tfstate-backend-example

Created as an exercise to:

1. Evaluate usability of `${path.root}/module` and `${path.root}/__environment__` directory structure
2. Implement mechansim that allows separate state files for each environment
3. Leverage Azure as a remote-backend for Terraform
4. Minimize initialization needed to setup remote backed for each environment

# Usage

## Create Prerequisites

The commands below will setup the prerequisites for the `azurerm` remote-backend. They will also generate the
`terraform.tf` file from template that is used to initialize the remote-backend.

```
terraform init
terraform plan
terraform apply
```

## Configure Remote-Backend

You should notice `terraform.tf` in your current working directory. The next set of commands will read the statements in
`terraform.tf` and configure the remote-backend.

```
teraform init --reconfigure
terraform plan
terraform apply
```

## Cleanup

Delete the leftover `terraform.tfstate` and `terraform.tfstate.backup` files by running: 

```
rm terraform.tfstate*
```
