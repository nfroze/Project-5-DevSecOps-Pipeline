# 📦 Project 5: End-to-End DevSecOps Transformation (EKS Edition)

## 1. Overview 🚀
This project demonstrates a full **DevSecOps implementation** for a lightweight Node.js web application, deployed securely on **Amazon EKS**. The goal is to simulate how a DevSecOps engineer would secure every phase of the SDLC in a real-world, Kubernetes-based, AWS-native environment.

The app is simple by design, allowing the spotlight to remain on **infrastructure security, pipeline automation, container security, and runtime protection**.

---

## 2. Project Goals 🎯
- Build and secure an app from scratch using **DevSecOps best practices**
- Showcase **end-to-end automation** of security checks
- Demonstrate shift-left security with tools integrated into CI/CD
- Simulate **production-grade monitoring and incident detection** on EKS

---

## 3. Key Technologies & Tools 🛠
- **Node.js + HTML/CSS** — Lightweight app
- **Terraform** — IaC to provision AWS VPC, EKS, IAM, and S3
- **Docker** — Containerization
- **GitHub Actions** — CI/CD pipeline
- **Snyk** — Open source vulnerability scanning (SCA)
- **SonarQube** — Static code analysis (SAST)
- **Checkov** — Terraform security scanning
- **Gitleaks** — Secrets detection
- **OWASP ZAP** — DAST scanning on live app
- **Amazon EKS** — Secure container orchestration on Kubernetes
- **Falco** — Runtime security alerts from within Kubernetes
- **Amazon GuardDuty** — AWS-native threat detection (30-day trial)
- **CloudWatch Container Insights** — Performance and resource monitoring for EKS
- **Splunk Free (self-hosted)** — Log aggregation, alert correlation (SIEM)
- **Slack** — Real-time alerting for incidents

---

## 4. CI/CD Workflow 🔄
1. **Code Push to GitHub** triggers a secure pipeline  
2. **Pre-Deployment Security Scans:**
   - SonarQube (SAST)
   - Snyk (SCA)
   - Gitleaks (Secrets detection)
   - Checkov (Terraform security scan)
3. **Infrastructure Provisioning:** Terraform deploys secure AWS resources (EKS, IAM, S3, VPC)
4. **Docker Image Build & Scan:** Image scanned using Trivy
5. **Deployment to EKS:** Securely deployed using least-privileged IAM roles and Kubernetes RBAC
6. **Post-Deployment Testing:** ZAP performs DAST on the live application

---

## 5. Monitoring & Security Stack 🔐

| Purpose                    | Tool                                |
|----------------------------|--------------------------------------|
| Runtime security (K8s)     | **Falco** — Alerts sent to Slack and Splunk |
| AWS-native threat detection| **Amazon GuardDuty** — 30-day free trial |
| Metrics/Performance        | **CloudWatch Container Insights**   |
| Alert forwarding           | **Slack** (via webhook or SNS)      |
| SIEM/log correlation       | **Splunk Free (self-hosted)**       |

---

## 6. Security Highlights 🔒
- **Shift-left scanning** of code, dependencies, secrets, and IaC
- **Runtime protection** with Falco and GuardDuty
- **CI/CD hardening** using GitHub Actions
- **Least-privilege IAM roles** for all AWS resources
- **Secure EKS setup** using Terraform
- **Real-time alerting and centralized log review** (Slack + Splunk)

---

## 7. Value for Organizations 💼
- Demonstrates **production-relevant DevSecOps practices**
- Showcases how to secure a full SDLC on AWS - same principles can be applied to any other cloud provider
- Highlights key DevSecOps principles: automation, visibility, runtime detection, IaC security
- Can be adapted for more complex real-world applications

---

## 8. Optional Production Enhancements 🛠️
> In production, additional log shipping is commonly implemented:
> - **Fluent Bit** or **CloudWatch Logs Agent** used to forward logs to a central SIEM
> - Helps with historical log analysis, compliance, and deep threat correlation

While excluded from this project to maintain simplicity, this enhancement is noted as a next step for scaling security observability.

---

## 9. Conclusion ✅
This project brings together the core concepts from Projects 1–4 into a cohesive, cloud-native DevSecOps pipeline. It simulates what a DevSecOps engineer would do in a real organization transitioning from insecure setups to fully monitored, secured, and automated Kubernetes deployments.

---

🔗 [Back to my GitHub Profile](https://github.com/nfroze)

> ✉️ Project 5 reflects what you’d actually see in modern production environments running Kubernetes on AWS.