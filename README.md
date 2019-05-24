# terraform-azure-lab

Created as an exercise to:

1. Evaluate usability of `${path.root}/module` and `${path.root}/__environment__` directory structure
2. Implement mechansim that allows separate state files for each environment
3. Leverage Azure as a remote-backend for Terraform
4. Minimize initialization needed to setup remote backed for each environment

# Project Structure

```
terraform-azure-lab/
├── README.md
├── environments
│   └── development
│       └── core
│           ├── main.tf
│           ├── terraform.tfstate
│           ├── terraform.tfstate.backup
│           └── variables.tf
└── modules
    └── common
        ├── application_gateway
        │   ├── main.tf
        │   ├── output.tf
        │   └── variables.tf
        ├── certificate
        │   ├── main.tf
        │   ├── output.tf
        │   └── variables.tf
        ├── compute
        │   └── linux_vm
        │       ├── main.tf
        │       ├── output.tf
        │       └── variables.tf
        ├── network
        │   └── virtual_network
        │       ├── main.tf
        │       ├── output.tf
        │       └── variables.tf
        ├── remote_state
        │   ├── main.tf
        │   ├── makefile
        │   ├── templates
        │   │   └── terraform.tf.tpl
        │   └── variables.tf
        ├── resource_group
        │   ├── main.tf
        │   ├── output.tf
        │   └── variables.tf
        └── storage
            └── key_vault
                ├── main.tf
                ├── output.tf
                └── variables.tf
```

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

## TODO

1. Fix error on `terraform destroy` since state file part of resources being destroyed
2. Reduce duplication in `main.tf` file between development and production
3. Reduce duplication in `variables.tf` file between development and production
4. Add appropriate license
