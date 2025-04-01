# 📦 Project 5: End-to-End DevSecOps Transformation

## 1. Overview 🚀
This project showcases a full **DevSecOps implementation** for a lightweight web application — built and secured entirely for the purpose of demonstrating secure Software Development Lifecycle (SDLC) practices.

The app is intentionally simple to reflect a **realistic solo project** by a DevSecOps engineer. The focus is not on complex features, but on embedding **security at every layer**: code, infrastructure, containers, CI/CD, and runtime.

---

## 2. Project Goals 🎯
- Simulate how a DevSecOps engineer would **build and secure** an app from day one
- Showcase **end-to-end automation** of security checks across the SDLC
- Demonstrate **shift-left principles** using industry-standard tools
- Prove real-world competency across IaC, container security, CI/CD, and runtime protection

---

## 3. Key Technologies & Tools 🛠
- **Node.js + HTML/CSS** — Lightweight app stack
- **Terraform** — Infrastructure as Code (AWS VPC, ECS, IAM, S3)
- **Docker** — Containerization
- **GitHub Actions** — CI/CD workflows
- **Trivy** — Container and SCA scanning
- **Checkov** — IaC security scanning
- **Semgrep** — Static code analysis (SAST)
- **Gitleaks** — Secret detection
- **OWASP ZAP** — Runtime/Dynamic application testing (DAST)
- **ECS** — Secure container orchestration and deployment

---

## 4. CI/CD Workflow 🔄
1. **Code Pushed to GitHub** triggers the workflow
2. **Pre-Deployment Security Scans**
   - Semgrep (SAST)
   - Trivy (SCA & Docker image scan)
   - Gitleaks (Secrets scan)
   - Checkov (Terraform IaC scan)
3. **Infrastructure Deployed** securely to AWS (VPC, IAM, ECS)
4. **App Containerized & Deployed** to ECS using least-privilege IAM roles
5. **DAST Scanning with ZAP** on the live app via Load Balancer

---

## 5. Security Highlights 🔐
- **IaC Security:** All cloud resources are provisioned securely via Terraform, with Checkov validating before deployment
- **Pipeline Security:** CI/CD pipeline integrates all major scan types (SAST, SCA, DAST, secrets, IaC)
- **Container Hardening:** Docker images are scanned, built from trusted bases, and deployed with least-privileged roles
- **Runtime Protection:** OWASP ZAP scans the deployed app for real-world attack vectors like XSS and SQLi
- **Auditability & Automation:** GitHub Actions workflows log and gate every step of the pipeline

---

## 6. Value for Organizations 💼
- Demonstrates **practical, hands-on DevSecOps capabilities**
- Provides a **blueprint for shift-left security** using open-source tools
- Shows how security can be embedded without disrupting development
- Highlights **automated compliance readiness** through scanning and logging

---

## 7. Conclusion ✅
This project represents the final piece in a broader DevSecOps portfolio. It ties together CI/CD security, container hardening, infrastructure-as-code, and real-world vulnerability testing to simulate a scalable, automated, and secure SDLC. 

> 📌 While the app is minimal by design, the security architecture reflects real-world best practices across modern cloud-native deployments.