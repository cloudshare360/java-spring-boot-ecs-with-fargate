# Requirements – Spring Boot to ECS Fargate

## Purpose
Provide a minimal Spring Boot HelloWorld service, containerize it, publish the image to Amazon ECR, and run it on an ECS cluster using the Fargate launch type. Include steps to verify the deployed service.

## Scope
- Application: Simple Spring Boot HelloWorld HTTP endpoint.
- Containerization: Docker image built locally.
- Registry: Amazon ECR repository for the image.
- Deployment: ECS Cluster with Fargate; service/task using the pushed image.
- Validation: Steps to test the running service once deployed.

## Functional Requirements
1) Spring Boot service
- Expose an HTTP endpoint (e.g., GET `/`) returning a static HelloWorld message.
- Built with Spring Boot 2.7.18 on Java 8 (JDK 1.8).
- Buildable with Maven or Gradle.

2) Docker image
- Provide a Dockerfile that builds a runnable image of the application.
- Image must start the Spring Boot app on container launch and expose the application port.

3) Publish to ECR
- Create or use an existing ECR repository.
- Authenticate to ECR using AWS CLI and push the built image with a tagged version.

4) ECS with Fargate
- Create an ECS cluster using the Fargate launch type.
- Define a task definition that references the ECR image and correct container port.
- Create a service (preferred) or run task that keeps the app running on Fargate.

5) Testing
- Provide steps to reach the service endpoint (e.g., via load balancer DNS or public IP) and verify the HelloWorld response.

## Non-Functional Requirements
- Use AWS-managed Fargate (no EC2 hosts to manage).
- Keep configuration minimal and cost-conscious (e.g., low task size such as 0.25 vCPU/0.5–1GB RAM if acceptable).
- Prefer IaC or CLI scripts that are repeatable; avoid manual console-only steps when possible.
- Include basic security hygiene: least-privilege IAM roles for task execution and ECR access; avoid embedding secrets in images.

## Assumptions / Prerequisites
- AWS account with permissions for ECR, ECS (Fargate), IAM role creation, and optional load balancer resources.
- AWS CLI installed and configured (`aws configure`) with appropriate credentials and region.
- Docker installed and running locally for image build and push.
- Java 8 (JDK 1.8) and Maven 3.6+ or Gradle available to build the Spring Boot app.

## Deliverables
- Spring Boot HelloWorld source code.
- Dockerfile for the application image.
- ECR repository reference and pushed image tag.
- ECS task definition and service (Fargate) using the ECR image.
- Testing instructions confirming the HelloWorld response from the deployed service.
