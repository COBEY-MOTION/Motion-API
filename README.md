Terraform Infrastructure for Motion-API

Overview

This repository contains Terraform code to provision cloud infrastructure for the Motion-API project. The infrastructure is designed to be modular and scalable, following best engineering practices.

Modules

The project is structured into three Terraform modules:

Networking

Creates a VPC, public and private subnets, internet gateway, and route tables.

Provides networking resources for other modules.

RDS (Relational Database Service)

Deploys a PostgreSQL database in private subnets.

Uses security groups to restrict access.

Stores database credentials in a secure way.

Bastion

Deploys an EC2 instance in a public subnet.

Serves as a jump host for accessing the private database.

Prerequisites

Before using this repository, ensure you have the following installed:

Terraform (>=1.0)

AWS CLI configured with valid credentials

An existing SSH key pair registered in AWS for accessing the Bastion host

An S3 bucket for storing Terraform remote state

File Structure

.
├── .gitignore                # Ignores Terraform state files and sensitive configs
├── main.tf                   # Root module that calls networking, rds, and bastion
├── variables.tf               # Global variables for the root module
├── terraform.tfvars           # (Optional) Defines values for root module variables
├── networking
│   ├── backend.tf             # S3 backend for storing state
│   ├── main.tf                # Defines VPC, subnets, and routes
│   ├── outputs.tf             # Outputs for other modules
│   ├── variables.tf           # Input variables for networking
├── rds
│   ├── main.tf                # Defines RDS database instance and security groups
│   ├── outputs.tf             # Outputs the DB endpoint
│   ├── variables.tf           # Input variables for RDS
│   ├── terraform.tfvars       # Stores sensitive DB credentials (DO NOT COMMIT)
├── bastion
│   ├── main.tf                # Deploys EC2 bastion host
│   ├── outputs.tf             # Outputs public IP of the bastion
│   ├── variables.tf           # Input variables for bastion

Usage

1. Initialize Terraform

Run the following command in the root directory to initialize the Terraform backend and download necessary modules:

terraform init

2. Plan the Infrastructure Changes

To preview the changes Terraform will make, run:

terraform plan

3. Apply the Changes

Deploy the infrastructure using:

terraform apply

Confirm by typing yes when prompted.

4. Destroy the Infrastructure

If you need to tear down the infrastructure, run:

terraform destroy

Confirm by typing yes when prompted.

Remote State Management

The networking module uses an S3 backend for remote state storage. This allows other modules (e.g., RDS and Bastion) to retrieve networking details dynamically.

If you're running Terraform in separate steps for each module, ensure the networking module is applied first:

cd networking
terraform apply

Then reference its outputs in RDS and Bastion using:

data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "your-terraform-state-bucket"
    key    = "networking/terraform.tfstate"
    region = "us-west-1"
  }
}

Security Best Practices

Never commit terraform.tfvars if it contains sensitive credentials. Use environment variables or a secret management tool.

Limit SSH access to the Bastion Host. For a production setup, restrict SSH access to trusted IPs instead of allowing all (0.0.0.0/0).

Enable state locking using a DynamoDB table to prevent simultaneous Terraform runs.

Next Steps

Add an Application Load Balancer (ALB) for future API services.

Deploy an EKS Cluster to run containerized applications in a scalable manner.

Implement IAM Role-Based Access Control (RBAC) to improve security.
