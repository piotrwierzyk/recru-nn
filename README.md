# NetNut Multi-Cloud Infrastructure

This project demonstrates the implementation of identical Kubernetes infrastructure on two cloud platforms: AWS (EKS) and Azure (AKS) using Terraform, Terragrunt, and Helm.

## 🏗️ Architecture

### AWS (EKS)
```
S3 Bucket (Terraform State)
  → VPC (10.0.0.0/16)
    → EKS 1.34 + Pod Identity
      → ALB Controller (EKS Pod Identity)
        → Hello-World App (Helm)
```

### Azure (AKS)
```
Storage Account (Terraform State)
  → VNet (10.1.0.0/16)
    → AKS + Workload Identity
      → AGIC (Application Gateway Ingress Controller)
        → Hello-World App (Helm)
```

## 📁 Project Structure

```
netnut/
├── aws/                          # AWS Infrastructure
│   ├── bootstrap/               # S3 bucket for Terraform state
│   ├── infrastructure/          # VPC + EKS
│   │   ├── modules/
│   │   │   ├── vpc/            # VPC, subnets, NAT Gateway
│   │   │   └── eks/            # EKS cluster + node group
│   │   └── outputs.tf          # Outputs for kubernetes layer
│   ├── kubernetes/             # ALB Controller + Hello-World
│   │   ├── alb-controller.tf   # AWS Load Balancer Controller
│   │   ├── addons.tf           # EKS Pod Identity Agent
│   │   └── hello-world.tf      # Hello-World application
│   └── terragrunt.hcl          # Root Terragrunt config
├── azure/                       # Azure Infrastructure
│   ├── bootstrap/              # Storage Account for Terraform state
│   ├── infrastructure/         # VNet + AKS + Application Gateway
│   │   ├── modules/
│   │   │   ├── vnet/          # Virtual Network + subnets
│   │   │   └── aks/           # AKS cluster
│   │   ├── appgw.tf           # Application Gateway
│   │   └── outputs.tf         # Outputs for kubernetes layer
│   ├── kubernetes/            # AGIC + Hello-World
│   │   ├── agic.tf            # Application Gateway Ingress Controller
│   │   └── hello-world.tf     # Hello-World application
│   └── terragrunt.hcl         # Root Terragrunt config
└── charts/                     # Shared Helm charts
    └── hello-world/           # Hello-World application
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            ├── deployment.yaml
            ├── service.yaml
            └── ingress.yaml
```

## 🚀 Deployment

### AWS

1. **Bootstrap** (S3 bucket):
```bash
cd aws/bootstrap
terragrunt apply
```

2. **Infrastructure** (VPC + EKS):
```bash
cd aws/infrastructure
terragrunt apply
```

3. **Kubernetes** (ALB Controller + Hello-World):
```bash
cd aws/kubernetes
terragrunt apply
```

### Azure

1. **Bootstrap** (Storage Account):
```bash
cd azure/bootstrap
terragrunt apply
```

2. **Infrastructure** (VNet + AKS + Application Gateway):
```bash
cd azure/infrastructure
terragrunt apply
```

3. **Kubernetes** (AGIC + Hello-World):
```bash
cd azure/kubernetes
terragrunt apply
```

## 🔧 Key Components

### AWS
- **EKS 1.34** 
- **EKS Pod Identity Agent** 
- **AWS Load Balancer Controller** 
- **ALB** 

### Azure
- **AKS 1.34** 
- **Application Gateway** 
- **AGIC** 
- **Workload Identity**

### Shared
- **Hello-World application** (Helm chart)
- **Terragrunt**

## 📋 Requirements

- Terraform >= 1.0
- Terragrunt >= 0.50
- AWS CLI (for AWS)
- Azure CLI (for Azure)
- kubectl
- helm

## 🎯 Project Goal

Demonstration of implementing identical functionality on two different cloud platforms using:
- Infrastructure as Code (Terraform)
- Orchestration (Terragrunt)
- Package management (Helm)
- Modern authentication (Pod Identity / Workload Identity)
- Minimalist architecture
