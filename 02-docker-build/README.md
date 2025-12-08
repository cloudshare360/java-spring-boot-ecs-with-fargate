# 02 - Docker Build

High-level steps:
- Create a Dockerfile to package the Spring Boot JAR into a runnable image.
- Build the image locally (e.g., `docker build -t <image-name>:<tag> .`).
- Test the image locally (`docker run -p 8080:8080 <image-name>:<tag>`) and hit the endpoint.
- Keep the tag consistent for the later ECR push.
