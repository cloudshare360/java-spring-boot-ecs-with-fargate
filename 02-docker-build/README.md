# 02 - Docker Build

## Overview
Create a Docker image for the Spring Boot HelloWorld application and test it locally before pushing to ECR.

## Prerequisites
- Docker Desktop installed and running
- Spring Boot JAR file built (from step 01)
- Basic understanding of Docker commands

## Application Details
- **Application JAR**: `helloworld-1.0.0.jar`
- **Java Version**: Java 8 (JDK 1.8)
- **Spring Boot Version**: 2.7.18
- **Application Port**: 8080
- **Context Path**: `/`
- **Health Endpoint**: `GET /` returns "Hello World from Spring Boot!"

## Dockerfile

Create a `Dockerfile` in the project root or `02-docker-build` directory:

```dockerfile
# Use Eclipse Temurin Java 8 base image (replaces deprecated openjdk)
FROM eclipse-temurin:8-jre-alpine

# Set working directory
WORKDIR /app

# Copy the JAR file from the build output
COPY ../01-spring-boot-app/target/helloworld-1.0.0.jar app.jar

# Expose the application port
EXPOSE 8080

# Set JVM options (optional)
ENV JAVA_OPTS="-Xmx256m -Xms128m"

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
```

## Build Docker Image

### Important: Build from Project Root
The Dockerfile must be built from the project root directory to access the JAR file.

```bash
# Navigate to project root (if you're in 02-docker-build)
cd ..

# Build using Dockerfile in root
docker build -t helloworld-springboot:latest .

# Build with specific version tag
docker build -t helloworld-springboot:1.0.0 .

# Build with multiple tags
docker build -t helloworld-springboot:latest -t helloworld-springboot:1.0.0 .
```

### Step 3: Verify Image
```bash
# List Docker images
docker images | grep helloworld

# Inspect image details
docker inspect helloworld-springboot:latest
```

## Run Docker Container Locally

### Basic Run
```bash
docker run -p 8080:8080 helloworld-springboot:latest
```

### Run in Detached Mode
```bash
docker run -d -p 8080:8080 --name helloworld-app helloworld-springboot:latest
```

### Run with Custom Port Mapping
```bash
# Map container port 8080 to host port 9090
docker run -d -p 9090:8080 --name helloworld-app helloworld-springboot:latest
```

### Run with Environment Variables
```bash
docker run -d -p 8080:8080 \
  -e JAVA_OPTS="-Xmx512m" \
  --name helloworld-app \
  helloworld-springboot:latest
```

### Run with Custom JVM Options
```bash
docker run -d -p 8080:8080 \
  -e JAVA_OPTS="-Xmx256m -XX:+UseG1GC" \
  --name helloworld-app \
  helloworld-springboot:latest
```

## Test the Container

### Test with curl
```bash
# Test endpoint
curl http://localhost:8080/

# Expected response
Hello World from Spring Boot!
```

### Test with PowerShell
```powershell
Invoke-WebRequest -Uri http://localhost:8080/ | Select-Object -ExpandProperty Content
```

### Test with Browser
Open: http://localhost:8080/

## Container Management

### View Running Containers
```bash
docker ps
```

### View Container Logs
```bash
# Follow logs
docker logs -f helloworld-app

# Last 100 lines
docker logs --tail 100 helloworld-app
```

### Stop Container
```bash
docker stop helloworld-app
```

### Start Container
```bash
docker start helloworld-app
```

### Restart Container
```bash
docker restart helloworld-app
```

### Remove Container
```bash
# Stop and remove
docker stop helloworld-app && docker rm helloworld-app

# Force remove (if running)
docker rm -f helloworld-app
```

## Tag Image for ECR

Prepare the image for pushing to Amazon ECR:

```bash
# Tag format: <aws-account-id>.dkr.ecr.<region>.amazonaws.com/<repository-name>:<tag>

# Example
docker tag helloworld-springboot:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/helloworld:latest

# With version tag
docker tag helloworld-springboot:1.0.0 123456789012.dkr.ecr.us-east-1.amazonaws.com/helloworld:1.0.0
```

## Multi-Stage Dockerfile (Optional)

For optimized builds, create a multi-stage Dockerfile:

```dockerfile
# Build stage
FROM maven:3.9-eclipse-temurin-8 AS build
WORKDIR /app
COPY ../01-spring-boot-app/pom.xml .
COPY ../01-spring-boot-app/src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
COPY --from=build /app/target/helloworld-1.0.0.jar app.jar
EXPOSE 8080
ENV JAVA_OPTS="-Xmx256m -Xms128m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
```

Build with multi-stage:
```bash
docker build -f Dockerfile.multistage -t helloworld-springboot:latest .
```

## Troubleshooting

### Image Build Fails
```bash
# Check Dockerfile syntax
docker build --no-cache -t helloworld-springboot:latest .

# Build with detailed output
docker build --progress=plain -t helloworld-springboot:latest .
```

### Container Fails to Start
```bash
# Check container logs
docker logs helloworld-app

# Run interactively to debug
docker run -it --rm helloworld-springboot:latest /bin/sh
```

### Port Already in Use
```bash
# Windows - Find process using port 8080
netstat -ano | findstr :8080

# Kill the process
taskkill /PID <process_id> /F

# Or use a different port
docker run -p 8081:8080 helloworld-springboot:latest
```

### Image Size Too Large
```bash
# Check image size
docker images helloworld-springboot

# Use alpine-based image or multi-stage build
# Clean up unused images
docker image prune -a
```

## Best Practices

1. **Use specific base image versions** - Avoid `latest` tags in production
2. **Minimize image layers** - Combine RUN commands when possible
3. **Use .dockerignore** - Exclude unnecessary files from build context
4. **Don't run as root** - Create a non-root user in production images
5. **Health checks** - Add HEALTHCHECK instruction for container orchestration
6. **Image scanning** - Scan images for vulnerabilities before deployment

## Next Steps

After successfully building and testing the Docker image:
1. Proceed to **03-ecr-publish** to push the image to Amazon ECR
2. Configure ECR repository and authentication
3. Push the tagged image to ECR for deployment

