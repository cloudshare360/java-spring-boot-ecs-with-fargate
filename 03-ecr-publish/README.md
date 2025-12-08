# 03 - ECR Publish

High-level steps:
- Ensure AWS CLI is configured (`aws configure`) and region is set.
- Create or identify the ECR repository.
- Authenticate Docker to ECR (e.g., `aws ecr get-login-password | docker login ...`).
- Tag the local image for ECR and push (`docker push <acct>.dkr.ecr.<region>.amazonaws.com/<repo>:<tag>`).
