.PHONY: plan

plan:
	terraform plan -out plan

apply:
	terraform apply "plan"

init:
	terraform init

fmt:
	terraform fmt -recursive

refresh-only:
	terraform apply -refresh-only
