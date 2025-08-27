# Project 5: DevSecOps Pipeline

## Overview

Security pipeline for Node.js application deployed to Amazon EKS. Automated security scanning integrated throughout CI/CD pipeline. AWS infrastructure provisioned through Terraform. Splunk SIEM integration for security monitoring.

## Architecture

### Pipeline Flow
1. Code pushed to GitHub
2. Security scanning (SAST, secrets, dependencies)
3. Container built and scanned
4. Deployment to EKS
5. Security events logged to Splunk

### Security Toolchain
- SAST: Semgrep for code vulnerabilities
- Secrets: Gitleaks for credential scanning
- SCA: Trivy for dependency vulnerabilities
- Container: Trivy for image scanning
- DAST: OWASP ZAP for runtime testing
- IaC: Checkov for Terraform compliance

### AWS Infrastructure
- EKS: Kubernetes cluster in private subnets
- Networking: VPC with public/private subnets
- Load Balancing: ALB for ingress
- Security: GuardDuty, CloudWatch, VPC Flow Logs

### Observability
- SIEM: Splunk for security event aggregation
- Monitoring: CloudWatch for infrastructure metrics
- Alerting: Splunk webhook integration

## Implementation

### Prerequisites
- AWS Account with EKS permissions
- Docker Hub account
- Splunk instance with HEC token
- GitHub repository with secrets

### Required GitHub Secrets
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- DOCKERHUB_USERNAME
- DOCKERHUB_TOKEN
- SPLUNK_HEC_URL
- SPLUNK_HEC_TOKEN

### Deployment Steps
1. Fork repository
2. Add required secrets to GitHub
3. Update Terraform backend configuration
4. Push to main branch

## Security Features

### Shift-Left Security
- Pre-commit: Gitleaks hooks
- CI Stage: SAST and dependency scanning
- Build Stage: Container scanning
- Deploy Stage: IaC compliance checks
- Runtime: DAST and monitoring

### Defense in Depth
- Network isolation with Kubernetes policies
- RBAC with least privilege
- Infrastructure as Code
- Container security contexts
- Centralised logging

## Technologies

- Cloud: AWS (EKS, VPC, IAM, ALB)
- IaC: Terraform
- Containers: Docker, Kubernetes
- CI/CD: GitHub Actions
- Security: Trivy, Semgrep, Gitleaks, OWASP ZAP, Checkov
- Monitoring: Splunk, CloudWatch
- Application: Node.js

## Screenshots

1. GitHub Actions pipeline with security checks
2. AWS EKS cluster running
3. Deployed application with load balancer
4. Splunk security dashboard

## Project Structure

```
Project-5-DevSecOps-Pipeline/
├── .github/workflows/    # CI/CD pipelines
├── terraform/            # Infrastructure code
├── k8s/                  # Kubernetes manifests
├── app/                  # Node.js application
├── docs/                 # Documentation
└── lambda/               # GuardDuty to Splunk integration
```

## Documentation

- Security Policy: Vulnerability handling procedures
- Security Exceptions: Documented risk decisions