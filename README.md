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

In the `build_demo` folder, run `ansible-playbook 00-prepare.yml`.

This will create all the AAP resources and some AWS resources to get started.

## When AAP is up and running

Under Automation Execution > Templates, run the workflow.

It will create two EC2 instances (CentOS Stream + Amazon Linux).

It will refresh the inventory (sourced from the Terraform state file stored in an S3 bucket).

It will install Apache on both instances.

 
