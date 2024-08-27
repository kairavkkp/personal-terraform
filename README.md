# personal-terraform
Personal Repo for Terraform

## Async Textract Tutorial
- Plan: 
```sh
terraform plan -target=module.textract_tutorial -out='tt_plan.tf' -var-file=variables.tfvars
```
- Apply: 
```sh
terraform apply -target=module.textract_tutorial 'tt_plan.tf'
```
- Remove the Plan File: 
```sh
rm tt_plan.tf
```