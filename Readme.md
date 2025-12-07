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


