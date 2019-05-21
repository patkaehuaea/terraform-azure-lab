TFSTATE=terraform.tfstate
TFSTATE_BACKUP=terraform.tfstate.bk


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

set-backend:
	@terraform init
	@terraform apply -auto-approve
	@terraform init --reconfigure -input=false
	@terraform apply -auto-approve
	if test -f "$TFSTATE"; then
    	rm $TFSTATE
	fi
	if test -f "$TFSTATE_BACKUP"; then
    	rm $TFSTATE_BACKUP
	fi
