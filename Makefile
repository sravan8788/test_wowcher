 all: init plan apply

app_port                    ?= 5050

init: check-var-env
	cd terraform/ && rm -rf .terraform/
	terraform -chdir=./terraform/ init -backend=true \
		-backend-config="./environments/$(env)/backend.tfvars"

validate: check-var-env 
	terraform -chdir=./terraform/ validate

plan: check-var-env  validate
	terraform -chdir=./terraform/  plan -var-file=./environments/$(env)/terraform.tfvars -var app_port=$(app_port)

apply: check-var-env 
	terraform -chdir=./terraform/ apply -auto-approve -var-file=./environments/$(env)/terraform.tfvars -var app_port=$(app_port)

refresh: check-var-env 
	terraform -chdir=./terraform/ refresh -var-file=./environments/$(env)/terraform.tfvars -var app_port=$(app_port)

destroy: check-var-env  init
	terraform -chdir=./terraform/ destroy -var-file=./environments/$(env)/terraform.tfvars -var app_port=$(app_port)

check-var-%:
	@ if [ "${${*}}" = "" ]; then echo "Environment variable $* not set"; exit 1; fi
