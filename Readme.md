# Spring Boot HelloWorld on ECS Fargate

## Overview
Minimal Spring Boot HelloWorld service that is containerized, pushed to Amazon ECR, and run on an ECS cluster using the Fargate launch type.

## Stack
- Java (Spring Boot)
- Docker for image build
- Amazon ECR for the registry
- Amazon ECS with Fargate for compute
- AWS CLI for orchestration

## Prerequisites
- AWS account with permissions for ECR, ECS (Fargate), and IAM roles
- AWS CLI installed and configured (`aws configure`)
- Docker installed and running locally
- Java build tool available (Maven or Gradle)

## Manual Workflow (one-time run)
1. Build the app: package the Spring Boot HelloWorld service.
2. Build and tag the Docker image locally.
3. Push the tagged image to an ECR repository.
4. Create an ECS cluster and task definition (Fargate) that references the ECR image.
5. Create an ECS service (Fargate) to run the task and expose the app port.
6. Test the endpoint via the service’s public endpoint or load balancer DNS.

## Testing
- Locate the service endpoint (e.g., ALB DNS or public IP if directly exposed).
- Verify the HelloWorld response: `curl http://<service-endpoint>/`

## Requirements
See `REQUIREMENTS.md` for the detailed requirements captured from the manual run.


## Repository
- GitHub: https://github.com/cloudshare360/java-spring-boot-ecs-with-fargate
- Clone: `git clone https://github.com/cloudshare360/java-spring-boot-ecs-with-fargate.git`

## Contribution Guidelines
- Use feature branches from `main`; prefer prefixes like `feature/`, `bugfix/`, `docs/`.
- Keep commits small and focused; include meaningful messages.
- Run build/tests locally before PRs; ensure Docker build succeeds.
- Avoid committing secrets (use `.gitignore` already present for `.git-credentials`).
- Open a PR to `main` with a short summary and any testing notes.

## Branching Strategy
- `main`: protected, always releasable.
- Working changes: create short-lived branches off `main` per change.
- After review, squash-merge to `main` unless history needs to be preserved.


