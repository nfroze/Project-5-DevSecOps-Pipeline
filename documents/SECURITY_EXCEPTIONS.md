# Security Exceptions and Design Decisions

This document explains security findings from our scanning tools and the rationale for our design decisions.

## Container Vulnerabilities - Accepted Risks

### Known CVEs
- **CVE-2024-21538 (cross-spawn@7.0.3)**: Regular Expression Denial of Service (ReDoS) vulnerability in npm's internal dependencies. This is NOT in our application code but in npm's bundled tooling. Risk is minimal as:
  - Container doesn't expose npm commands to external input
  - Attack requires crafted malicious input to npm CLI
  - Vulnerability is in build tooling, not runtime application
  - Fix requires updating Node.js base image to include newer npm version

## Checkov Findings - Accepted Risks

### Lambda Functions (Low Risk)
- **No Dead Letter Queue (DLQ)**: Our Lambda functions forward logs to Splunk. If they fail, CloudWatch/EventBridge will retry. DLQ adds unnecessary complexity for this use case.
- **No VPC Configuration**: These Lambdas only need to reach AWS services (EventBridge, CloudWatch) and Splunk. VPC would add NAT Gateway costs and complexity without security benefit.
- **No X-Ray Tracing**: This is a monitoring feature, not a security requirement. Splunk provides sufficient observability.
- **No Code Signing**: Appropriate for enterprise environments but overkill for a demo project with controlled deployments.

### EKS Public Endpoint (Medium Risk - Mitigated)
- **Public API Endpoint Required**: GitHub Actions needs to deploy to the cluster. In production, we would:
  - Use a self-hosted runner inside the VPC
  - Or restrict public_access_cidrs to GitHub's IP ranges
  - Or use AWS Systems Manager for access

### VPC Public Subnets (By Design)
- **Auto-assign Public IPs**: Required for NAT Gateway functionality in public subnets. Private subnets do NOT auto-assign public IPs, maintaining security.

### CloudWatch Logs (Low Risk)
- **30-day Retention**: Sufficient for demo. Production would use 365+ days for compliance.
- **No KMS Encryption**: CloudWatch Logs are encrypted at rest by default. KMS adds cost without significant security benefit for demo logs.

### DynamoDB State Lock Table (Low Risk)
- **No Point-in-Time Recovery**: This table only stores Terraform locks, not application data. Locks are ephemeral.
- **Default Encryption**: Uses AWS-managed keys. Sufficient for lock data.

## Security Strengths Demonstrated

Despite these exceptions, our infrastructure demonstrates strong security:

1. **Network Isolation**: Private subnets for compute, public only for load balancers
2. **IAM Least Privilege**: All roles follow principle of least privilege
3. **Encryption in Transit**: TLS everywhere
4. **No Hardcoded Secrets**: All sensitive data in environment variables
5. **Comprehensive Scanning**: SAST, SCA, Container, IaC, and DAST scanning
6. **Runtime Protection**: GuardDuty enabled for threat detection
7. **Audit Logging**: VPC Flow Logs, EKS audit logs, CloudTrail implied

## Recommendations for Production

To address the remaining findings in a production environment:

1. Implement KMS encryption for all resources
2. Use PrivateLink endpoints for AWS services  
3. Implement AWS WAF on the load balancer
4. Add AWS Config for compliance monitoring
5. Use AWS Secrets Manager instead of environment variables
6. Implement least-privilege security groups
7. Enable AWS Shield for DDoS protection

These exceptions are documented and understood, demonstrating mature security thinking appropriate for a DevSecOps role.