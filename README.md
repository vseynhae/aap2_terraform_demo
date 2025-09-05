# Terraform + Ansible Demo

This repository was used during @vseynhae and @sebw talk at Red Hat Tech Day Luxembourg (branch `techday`) and Voxxed Days Luxembourg 2025 (branch `main`).

Slides are available [here](https://raw.githubusercontent.com/sebw/aap2_terraform_demo/refs/heads/main/pdf/voxxed.pdf)

This repository is meant to be reused by Red Hat customers or partners to quickly get up to speed with Terraform inside Ansible Automation Platform workflows.

## Intro

Configuration files and examples used for demonstrating Terraform and Ansible Automation Platform (AAP) integrations. 

Initially we will demonstrate Terraform and Ansible, individually from the CLI (folders `ansible-cli` and `terraform-cli`).

This will bring up some challenges around the shared management of:

- credentials (AWS, SSH)
- Ansible inventory
- terraform state file

We will integrate both technologies inside AAP:

- Running the Terraform code individually inside AAP
- Include the Terraform code as part of a larger workflow (day 1 + day 2)
- An approval will be requested to perform the terraform apply
- AAP will manage the Terraform State file in an S3 bucket
- We'll use the Terraform State file as a dynamic inventory in order to post configure EC2 instances

## Requirements

- an AWS account with sufficient permissions
- a ready to use AAP 2.5 with admin permissions
  - it is advised to use a non production AAP for your demo
  - admin rights are needed because we create objects in AAP that can only be done by an admin
- an Ansible Execution Environment that contains the `cloud.terraform` Ansible Collection and the `terraform` binary (prebuilt for the demo and available at `ghcr.io/sebw/ee_terraform`)
- `botocore` & `boto3` python libraries are needed on the machine used to stand up the demo environment.

For example on a RHEL machine you would need to run:

```
pip3 install botocore boto3
```

## Preparing your AAP and AWS environments

In the `build_demo` folder, replace the vault.yml with your own.

```
cd AAP2_terraform
rm build_demo/vault.yml
ansible-vault create build_demo/vault.yml
```

The vault structure should look like this and contain sensitive information.

Adjust AWS region as needed:

```yaml
aap2_host: your-aap-hostname
aap2_username: admin
aap2_password: your-aap-admin-password

aws_access: your-aws-access
aws_secret: your-aws-secret
aws_region: eu-central-1

# no special characters in the name. Must be unique within AWS tenant.
aws_bucket_name: yourbucket

ssh_public_key: "ssh-rsa XYZ"

ssh_private_key: |
    -----BEGIN OPENSSH PRIVATE KEY-----
    YOUR SSH PRIVATE KEY HERE
    -----END OPENSSH PRIVATE KEY-----
```

Edit `00-prepare.yml` and update `demo_name` (e.g.: CTOdemo).

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

Those resources will be created in the AWS region specified in your vault.

## When AAP is up and running

Under Automation Execution > Templates, run the workflow called "Workflow all in one".

It will create a RHEL EC2 instance using Terraform.

When Terraform is done, the state file is stored in the S3 bucket.

The workflow will refresh the inventory (based on the state file).

An approval will be needed to resume the workflow (see the blue bell icon in the upper right corner of AAP web interface).

If approved, the next job will install Apache on the instances found in the Terraform state file.
