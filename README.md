# Terraform + Ansible Demo

Configuration files and examples used for demonstrating Terraform and Ansible Automation Platform (AAP) integrations. 

Features demonstrated include:

- Terraform backend credential type in Ansible Automation Platform
- Terraform state inventory source in Ansible Automation Platform
- Running your Terraform code inside an AAP workflow 

## Requirements

- an AWS account
- an AAP 2.5 with admin rights

## Preparing your AAP and AWS environments

In the `build_demo` folder, replace the vault.yml with your own.

The vault structure should look like this:

```json
aap2_host: your-aap-hostname
aap2_username: admin
aap2_password: your-aap-admin-password

aws_access: your-aws-access
aws_secret: your-aws-secret

ssh_public_key: "ssh-rsa XYZ"

ssh_private_key: |
    -----BEGIN OPENSSH PRIVATE KEY-----
    YOUR SSH PRIVATE KEY HERE
    -----END OPENSSH PRIVATE KEY-----
                                        
```

Run `ansible-playbook 00-prepare.yml`.

This will create all the AAP resources:

- organization
- project
- credentials
  - to access AWS
  - to store the Terraform state file in an S3 bucket
  - the SSH credential to connect to the EC2 instances 
- some jobs
- a workflow that plugs those jobs

Some AWS resources: 

- a key pair that will be used by AAP to post provision EC2 instances
- an S3 bucket that will be used to store the Terraform State file

## When AAP is up and running

Under Automation Execution > Templates, run the workflow.

It will create two EC2 instances (CentOS Stream + Amazon Linux).

It will refresh the inventory (sourced from the Terraform state file stored in an S3 bucket).

It will install Apache on both instances.

 
