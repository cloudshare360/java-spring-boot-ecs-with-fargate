# 04 - ECS Fargate Deploy

High-level steps:
- Create an ECS cluster with Fargate capacity.
- Define a task definition referencing the ECR image and container port.
- Create a service (Fargate) to run and maintain the task; optionally attach an ALB for HTTP access.
- Confirm the service reaches a stable state and tasks are running.
