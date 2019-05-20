# Steps

1. Run `terraform init`
2. Run `terraform plan`
3. Run `terraform apply`

Note at this point the `terraform.tf` file will be present. In order to leverage the remote backend for Azure, you must
do the following:

1. Run `teraform init --reconfigure`
2. Answer `yes` when asked to migrate from local to remote
3. Run `terraform plan`
4. Run `terraform apply`
