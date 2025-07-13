# Project 5: End-to-End DevSecOps Transformation

## 🎯 Overview
This project demonstrates a complete end-to-end DevSecOps pipeline for a Node.js application deployed on AWS EKS, incorporating security scanning at every stage of the SDLC.

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────────────────────────────────────────┐
│                              DevSecOps Pipeline Architecture                          │
└──────────────────────────────────────────────────────────────────────────────────────┘

    Developer                   CI/CD Pipeline                    AWS Infrastructure
        │                                                                │
        ▼                                                                ▼
   ┌─────────┐    ┌───────────────────────────────────┐    ┌─────────────────────┐
   │ GitHub  │───▶│  🔒 Security Scanning at Each Stage │───▶│   🚀 EKS Cluster    │
   └─────────┘    └───────────────────────────────────┘    └─────────────────────┘
                            │                                           │
                            ▼                                           ▼
                  ┌─────────────────────┐                    ┌─────────────────────┐
                  │ CI: Code Security   │                    │ Runtime Security    │
                  │ • Semgrep (SAST)    │                    │ • GuardDuty         │
                  │ • Gitleaks (Secrets)│                    │ • VPC Flow Logs     │
                  │ • Trivy (SCA)       │                    │ • CloudWatch        │
                  └─────────────────────┘                    └─────────────────────┘
                            │                                           │
                            ▼                                           ▼
                  ┌─────────────────────┐                    ┌─────────────────────┐
                  │ Build: Container    │                    │   Load Balancer     │
                  │ • Trivy Image Scan  │                    │   ┌─────────────┐   │
                  │ • Docker Security   │                    │   │ OWASP ZAP   │   │
                  │ • Push to Registry  │                    │   │ DAST Scan   │   │
                  └─────────────────────┘                    │   └─────────────┘   │
                                                             └─────────────────────┘
                                        │                               │
                                        └───────────────────────────────┘
                                                        ▼
                                              ┌─────────────────────┐
                                              │   📊 Splunk SIEM    │
                                              │ • Centralized Logs  │
                                              │ • Security Events   │
                                              │ • Real-time Alerts  │
                                              └─────────────────────┘
```

### Pipeline Flow

1. **Source Control** → Developer pushes code to GitHub
2. **CI Pipeline** → Automated security scans (SAST, Secrets, Dependencies)
3. **Build Pipeline** → Container build and vulnerability scanning
4. **CD Pipeline** → Deploy to EKS with runtime security checks
5. **Monitoring** → All security events flow to Splunk SIEM

### Security Controls by Stage

| Stage | Security Tools | Purpose |
|-------|---------------|---------|
| **Code** | Semgrep, Gitleaks, Trivy | Find vulnerabilities before build |
| **Build** | Trivy, Docker Security | Secure container images |
| **Deploy** | Checkov, OWASP ZAP | IaC compliance & runtime testing |
| **Runtime** | GuardDuty, CloudWatch, Splunk | Continuous threat monitoring |
### Pipeline Flow

1. **Source Control** → Developer pushes code to GitHub
2. **CI Pipeline** → Automated security scans (SAST, Secrets, Dependencies)
3. **Build Pipeline** → Container build and vulnerability scanning
4. **CD Pipeline** → Deploy to EKS with runtime security checks
5. **Monitoring** → All security events flow to Splunk SIEM

### Security Controls by Stage

| Stage | Security Tools | Purpose |
|-------|---------------|---------|
| **Code** | Semgrep, Gitleaks, Trivy | Find vulnerabilities before build |
| **Build** | Trivy, Docker Security | Secure container images |
| **Deploy** | Checkov, OWASP ZAP | IaC compliance & runtime testing |
| **Runtime** | GuardDuty, CloudWatch, Splunk | Continuous threat monitoring |

### Key Components

**CI/CD Pipeline**
- **Source Control**: GitHub with branch protection and PR reviews
- **CI Stage**: Automated SAST, SCA, and secret scanning
- **Build Stage**: Container building and vulnerability scanning
- **CD Stage**: Automated deployment and DAST scanning
- **Registry**: Docker Hub for container images

**AWS Infrastructure**
- **Compute**: EKS cluster in private subnets
- **Networking**: VPC with public/private subnet isolation
- **Load Balancing**: ALB for external traffic
- **Security**: GuardDuty, CloudWatch, VPC Flow Logs

**Security Toolchain**
- **SAST**: Semgrep for code analysis
- **SCA**: Trivy for dependency scanning
- **Secrets**: Gitleaks for credential detection
- **Container**: Trivy for image scanning
- **DAST**: OWASP ZAP for runtime testing
- **IaC**: Checkov for Terraform scanning

**Observability**
- **SIEM**: Splunk for centralized security events
- **Metrics**: CloudWatch for infrastructure monitoring
- **Alerting**: Splunk to Slack integration

## 🔒 Security Controls

### Source Code Security (CI Stage)
- **Gitleaks**: Scans for hardcoded secrets and credentials
- **Semgrep**: Static application security testing (SAST)
- **Trivy**: Software composition analysis (SCA) for dependencies

### Container Security (Build Stage)
- **Trivy**: Vulnerability scanning of Docker images
- **Docker Security**: Non-root user, read-only filesystem, security contexts

### Infrastructure Security (IaC)
- **Checkov**: Terraform security and compliance scanning
- **AWS Security**: VPC isolation, security groups, IAM least privilege

### Runtime Security (CD Stage)
- **OWASP ZAP**: Dynamic application security testing (DAST)
- **GuardDuty**: AWS threat detection (planned)
- **Kubernetes Security**: Network policies, pod security standards

## 🚀 Quick Start

### Prerequisites
- AWS Account with appropriate permissions
- Docker Hub account
- Splunk instance with HEC configured
- GitHub repository with secrets configured

### Required GitHub Secrets
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
SPLUNK_HEC_URL
SPLUNK_HEC_TOKEN

### Deployment Steps
1. Fork this repository
2. Configure the required GitHub secrets
3. Update the Terraform backend configuration
4. Push to main branch to trigger the pipeline

## 📊 Monitoring & Alerting

- **Splunk**: Centralized logging and security event management
- **Prometheus/Grafana**: Metrics and visualization (optional)
- **Slack Integration**: Real-time security alerts (via Splunk)

## 🔄 Pipeline Flow

1. **Developer** pushes code to GitHub
2. **CI Pipeline** runs security scans on source code
3. **Build Pipeline** builds and scans Docker image
4. **CD Pipeline** deploys to EKS and runs DAST scans
5. **Monitoring** collects all security events in Splunk

## 📈 Improvements & Future Work

- [ ] Implement Falco for runtime threat detection
- [ ] Add RBAC and service mesh (Istio)
- [ ] Implement GitOps with ArgoCD
- [ ] Add performance testing with K6
- [ ] Implement secret management with HashiCorp Vault

## 🏆 Key Achievements

- **Shift-left security**: Security integrated at every stage
- **Automated compliance**: Policy-as-code with Checkov
- **Zero-trust networking**: Kubernetes network policies
- **Immutable infrastructure**: GitOps principles
- **Full observability**: Centralized logging and monitoring

## 📚 Technologies Used

- **Cloud**: AWS (EKS, VPC, IAM)
- **IaC**: Terraform
- **Container**: Docker, Kubernetes
- **CI/CD**: GitHub Actions
- **Security Tools**: Trivy, Semgrep, Gitleaks, OWASP ZAP, Checkov
- **Monitoring**: Splunk, Prometheus, Grafana
- **Languages**: Node.js, HCL, YAML

## 📝 Notes for Interviewers

This project demonstrates:
- Understanding of DevSecOps principles and practices
- Ability to implement security at every stage of SDLC
- Knowledge of cloud-native security tools and practices
- Focus on automation and repeatability
- Balance between security and developer experience

Each tool was chosen for a specific purpose, avoiding redundancy while ensuring comprehensive coverage. The pipeline is designed to fail fast on security issues while providing clear feedback to developers.