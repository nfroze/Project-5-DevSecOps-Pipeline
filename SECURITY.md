# Security Policy

## 🛡️ Security Controls by Layer

### Application Security
- **SAST**: Semgrep scans for vulnerable code patterns
- **SCA**: Trivy scans for vulnerable dependencies
- **Secrets**: Gitleaks prevents credential leaks
- **DAST**: OWASP ZAP tests running application

### Container Security
- **Base Image**: Official Node.js Alpine (minimal attack surface)
- **User**: Non-root user (UID 10001)
- **Filesystem**: Read-only root filesystem
- **Capabilities**: All capabilities dropped
- **Scanning**: Automated vulnerability scanning pre-deployment

### Kubernetes Security
- **Namespace**: Isolated `project5` namespace
- **Service Account**: Disabled auto-mounting
- **Security Context**: Enforced at pod and container level
- **Network Policy**: Restricted ingress/egress (planned)
- **Resources**: CPU/Memory limits prevent DoS

### Infrastructure Security
- **Network**: Private subnets for compute
- **Encryption**: TLS in transit, encryption at rest
- **IAM**: Least privilege roles
- **Logging**: VPC Flow Logs, CloudWatch, GuardDuty
- **Compliance**: Checkov policy scanning

## 🚨 Vulnerability Management

### Severity Levels
- **Critical**: Blocks deployment, immediate fix required
- **High**: Blocks deployment, fix within 24 hours
- **Medium**: Warning, fix within 7 days
- **Low**: Tracked, fix in next release

### Response Process
1. **Detection**: Automated scanning in CI/CD
2. **Alert**: Splunk → Slack notification
3. **Triage**: Assess impact and exploitability
4. **Remediation**: Update dependency or code
5. **Verification**: Re-run pipeline to confirm fix

## 📊 Security Metrics

Tracked in Splunk dashboards:
- Mean time to detect (MTTD)
- Mean time to remediate (MTTR)
- Vulnerability density by severity
- Security scan pass/fail rate
- Secret detection attempts

## 🔐 Secret Management

- **Development**: GitHub Secrets
- **Production**: AWS Secrets Manager (future)
- **Rotation**: 90-day policy
- **Detection**: Gitleaks in CI pipeline
- **Response**: Immediate rotation if exposed

## 📞 Security Contacts

For security issues:
- Create private security advisory in GitHub
- Do not create public issues for vulnerabilities
- Include: description, impact, steps to reproduce

## 🔄 Security Review Schedule

- **Weekly**: Review Splunk alerts and metrics
- **Monthly**: Update dependencies and base images
- **Quarterly**: Review and update security policies
- **Annually**: Full security architecture review