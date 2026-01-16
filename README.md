🚀 Todo App Deployment using Azure VMSS (Terraform)

This repository demonstrates an end-to-end Azure infrastructure deployment using Terraform, where a Todo application is deployed on Virtual Machine Scale Sets (VMSS) with secure networking and secret management.

The project follows real-world enterprise best practices such as:

Modular Terraform design

Environment-based configuration

Secure secret handling using Azure Key Vault

Scalable compute using VMSS

Bastion-based secure access

🧱 Architecture Overview

High-level flow:

User
  |
Application Gateway / Load Balancer
  |
VM Scale Set (Private IP)
  |
Azure Key Vault (Secrets)
  |
Azure Storage / Other Services


Key highlights:

No public IP on VMs

Secure SSH/RDP using Azure Bastion

Secrets are NOT hardcoded

Fully automated via Terraform

📁 Repository Structure
todo_app_deploy_using_vmss/
│
├── environments/
│   └── dev/
│       ├── main.tf               # Root module for DEV environment
│       ├── provider.tf           # Azure provider configuration
│       ├── variables.tf          # Input variable definitions
│       ├── terraform.tfvars      # DEV environment values
│       ├── terraform.tfstate*    # Terraform state (local)
│       └── .terraform/           # Terraform working directory
│
├── modules/
│   ├── resource_group/           # Azure Resource Group
│   ├── virtual_network/          # VNet configuration
│   ├── subnet/                   # Subnets (VMSS, Bastion, etc.)
│   ├── network_security_group/   # NSG rules
│   ├── network_interface/        # NIC module
│   ├── nic_nsg_association/      # NIC–NSG association
│   ├── public_ip/                # Public IPs (Bastion / LB)
│   ├── load_balancer/            # Load Balancer
│   ├── application_gateway/      # Application Gateway
│   ├── azure_bastion/            # Azure Bastion Host
│   ├── virtual_machine_scale_set/# VM Scale Set
│   ├── storage_account/          # Azure Storage Account
│   └── key_vault/                # Azure Key Vault + Access Policies
│
├── .gitignore
├── README.md
└── terraform.tfstate.backup

🔐 Azure Key Vault Design

Azure Key Vault is used to securely store secrets such as:

Database passwords

Application secrets

Storage account keys (optional)

Key Vault Creation

Created using a dedicated Terraform module

Supports multiple Key Vaults using for_each

Environment-specific configuration via terraform.tfvars

Access Policy Strategy

Key Vault resource does NOT hardcode access policies

Access is managed separately using:

azurerm_key_vault_access_policy

This allows:

VM Managed Identity access

App Service / Pipeline access

Clean separation of concerns

📦 VM Scale Set (VMSS)

VMSS is deployed with private IP only

Integrated with:

Load Balancer / Application Gateway

NSG for traffic control

Designed for:

Auto-scaling

High availability

Zero manual intervention

🔐 Azure Bastion

Used for secure VM access

No public IP required on VMs

SSH/RDP via Azure Portal

Bastion subnet is deployed separately

🌍 Environment Strategy

Currently implemented:

✅ DEV environment

Design supports:

DEV / QA / UAT / PROD

Each environment can have:

Separate terraform.tfvars

Different sizing and permissions

Same reusable modules

⚙️ Prerequisites

Before running Terraform:

Azure Subscription

Terraform >= 1.x

Azure CLI installed

Logged in using:

az login

🚀 How to Deploy
cd environments/dev
terraform init
terraform plan
terraform apply -auto-approve

🧹 How to Destroy
terraform destroy -auto-approve

🛡️ Security Best Practices Followed

❌ No secrets in code

✅ Azure Key Vault for secret management

✅ Managed Identity preferred over credentials

✅ Private networking

✅ Bastion for secure access

✅ Modular Terraform design

🎯 Interview-Ready Highlights

End-to-end Azure Infra using Terraform

VMSS with private networking

Secure secret handling using Key Vault

Enterprise-grade Terraform module structure

Environment-based deployments

📌 Future Enhancements

CI/CD pipeline (Azure DevOps / GitHub Actions)

Key Vault RBAC-based authorization

Auto-scaling rules for VMSS

Application deployment automation

Monitoring with Azure Monitor & Log Analytics

👤 Author

Shashi Singh
Azure | Terraform | DevOps
GitHub: https://github.com/ShashiSingh72
