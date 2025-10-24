# Infrastructure as Code - Multi-Cloud Kubernetes

This repository contains Terraform modules for deploying Kubernetes infrastructure on AWS (EKS) and Azure (AKS) with ingress controllers and sample applications.

## Structure

```
.
├── modules/
│   ├── network/
│   │   ├── aws/              # VPC for AWS
│   │   └── azure/            # VNet for Azure
│   ├── kubernetes/
│   │   ├── aws/              # EKS + ALB Controller + addons
│   │   └── azure/            # AKS + Application Gateway + AGIC
│   └── applications/
│       └── hello-world/      # Sample hello-world application
├── infrastructure/
│   ├── aws/                  # AWS environment
│   └── azure/                # Azure environment
└── charts/
    └── hello-world/          # Helm chart for hello-world app
```

## Prerequisites

- Terraform >= 1.0
- AWS CLI (for AWS deployment)
- Azure CLI (for Azure deployment)
- kubectl
- helm

## Quick Start

### AWS Deployment

```bash
cd infrastructure/aws
terraform init
terraform plan
terraform apply
```

### Azure Deployment

```bash
cd infrastructure/azure
terraform init
terraform plan
terraform apply
```

## Module Overview

### Network Modules
- **network/aws**: Creates VPC with public and private subnets, NAT Gateway, Internet Gateway
- **network/azure**: Creates VNet with subnets for AKS and Application Gateway

### Kubernetes Modules
- **kubernetes/aws**: Deploys EKS cluster, node group, addons (CoreDNS, Pod Identity Agent), and AWS Load Balancer Controller
- **kubernetes/azure**: Deploys AKS cluster, Application Gateway, and AGIC (Application Gateway Ingress Controller)

### Application Modules
- **applications/hello-world**: Deploys hello-world application using Helm chart with appropriate ingress configuration

### AWS EKS
```bash
aws eks update-kubeconfig --region eu-central-1 --name pw-eks
kubectl get nodes
```

### Azure AKS
```bash
az aks get-credentials --resource-group pw-rg --name pw-aks
kubectl get nodes
```

## Accessing the Hello World Application

After deployment, the hello-world application will be accessible via the load balancer:

### AWS
The ALB DNS name will be in the ingress:
```bash
kubectl get ingress -n default
```

### Azure
The Application Gateway public IP is outputted:
```bash
terraform output hello_world_url
```

## Cleanup

To destroy all resources:

```bash
# AWS
cd infrastructure/aws
terraform destroy

# Azure
cd infrastructure/azure
terraform destroy
```

