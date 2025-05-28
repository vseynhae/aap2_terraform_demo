# Terraform CLI

Terraform code to deploy a basic infrastructure in AWS


## Preparing your environment


1. Install Terraform

	```
	sudo yum install -y yum-utils
	sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
	sudo yum -y install terraform
	```

1. Define your credentials as environment variables

	```
	export AWS_ACCESS_KEY_ID="redacted"
	export AWS_SECRET_ACCESS_KEY="redacted"
	
	```

1. Initialize Terraform

	`terraform init`

1. Create Terraform's plan

	`terraform plan`

1. Deploy resources

	`terraform apply`
