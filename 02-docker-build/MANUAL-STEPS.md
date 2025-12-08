# Docker Build - Manual Execution Steps

## Step-by-Step Guide

### Prerequisites Check

1. **Verify Docker is running**
   ```powershell
   docker --version
   ```
   Expected output: `Docker version XX.XX.XX, build XXXXXXX`

2. **Verify Java 8 is installed**
   ```powershell
   java -version
   ```
   Expected output: `java version "1.8.0_XXX"`

3. **Verify Maven is installed**
   ```powershell
   mvn -version
   ```
   Expected output: `Apache Maven 3.X.X`

---

## Part 1: Build Spring Boot Application

### Step 1: Navigate to Spring Boot project directory
```powershell
cd D:\working\Technologies\java-spring-boot-ecs-with-fargate\01-spring-boot-app
```

### Step 2: Clean previous builds (optional but recommended)
```powershell
mvn clean
```
Expected: `BUILD SUCCESS` message

### Step 3: Compile and package the application
```powershell
mvn package
```
Expected: 
- `BUILD SUCCESS` message
- Tests should pass (2 tests)
- JAR file created at `target/helloworld-1.0.0.jar`

### Step 4: Verify JAR file exists
```powershell
ls target\helloworld-1.0.0.jar
```
Expected: File details showing the JAR file

### Step 5 (Optional): Test JAR locally
```powershell
java -jar target\helloworld-1.0.0.jar
```
- Application should start on port 8080
- Press `Ctrl+C` to stop
- Test in browser: http://localhost:8080/

---

## Part 2: Build Docker Image

### Step 6: Navigate to project root
```powershell
cd D:\working\Technologies\java-spring-boot-ecs-with-fargate
```
**Important:** You must be in the project root, NOT in `01-spring-boot-app` or `02-docker-build`

### Step 7: Verify you're in the correct directory
```powershell
ls
```
Expected output should show:
- `01-spring-boot-app/`
- `02-docker-build/`
- `Dockerfile`
- `.dockerignore`

### Step 8: Build Docker image
```powershell
docker build -t helloworld-springboot:latest .
```

What happens during build:
1. Downloads Eclipse Temurin Java 8 Alpine base image (first time only)
2. Creates working directory `/app` in container
3. Copies JAR file from `01-spring-boot-app/target/`
4. Sets environment variables
5. Configures container to run the application

Expected output:
- Multiple steps showing `[1/3]`, `[2/3]`, `[3/3]`
- Final message: `=> exporting to image`
- `=> naming to docker.io/library/helloworld-springboot:latest`

### Step 9: Verify image was created
```powershell
docker images | Select-String "helloworld"
```
Expected: Shows `helloworld-springboot` with tag `latest` and size (~100MB)

### Step 10: Inspect image details (optional)
```powershell
docker inspect helloworld-springboot:latest
```

---

## Part 3: Run Docker Container

### Step 11: Check if port 8080 is available
```powershell
netstat -ano | findstr :8080
```
- If nothing shows up: Port is available ✅
- If something shows up: Port is in use, kill the process or use different port

### Step 12: Run container in detached mode
```powershell
docker run -d -p 8080:8080 --name helloworld-app helloworld-springboot:latest
```

Explanation of flags:
- `-d` = Detached mode (runs in background)
- `-p 8080:8080` = Maps host port 8080 to container port 8080
- `--name helloworld-app` = Names the container for easy reference
- `helloworld-springboot:latest` = Image to run

Expected: Long container ID (e.g., `4f20ce9fb25aa358a3a385f9d10b203a...`)

### Step 13: Verify container is running
```powershell
docker ps
```
Expected: Shows `helloworld-app` container with status `Up X seconds`

### Step 14: Check container logs
```powershell
docker logs helloworld-app
```
Expected: Spring Boot startup logs showing:
- `Starting HelloWorldApplication`
- `Started HelloWorldApplication in X seconds`
- No errors

### Step 15: Follow logs in real-time (optional)
```powershell
docker logs -f helloworld-app
```
Press `Ctrl+C` to stop following

---

## Part 4: Test the Application

### Step 16: Test with PowerShell
```powershell
Invoke-WebRequest -Uri http://localhost:8080/ | Select-Object -ExpandProperty Content
```
Expected output: `Hello World from Spring Boot!`

### Step 17: Test with curl (if installed)
```powershell
curl http://localhost:8080/
```
Expected output: `Hello World from Spring Boot!`

### Step 18: Test in web browser
Open your browser and go to: **http://localhost:8080/**

Expected: Page displays `Hello World from Spring Boot!`

---

## Part 5: Container Management

### View container status
```powershell
docker ps
```

### View all containers (including stopped)
```powershell
docker ps -a
```

### Stop the container
```powershell
docker stop helloworld-app
```

### Start the container again
```powershell
docker start helloworld-app
```

### Restart the container
```powershell
docker restart helloworld-app
```

### View resource usage
```powershell
docker stats helloworld-app
```
Press `Ctrl+C` to exit

### Execute commands inside container
```powershell
docker exec -it helloworld-app sh
```
Now you're inside the container. Type `exit` to leave.

### Remove the container (must be stopped first)
```powershell
docker stop helloworld-app
docker rm helloworld-app
```

### Force remove (even if running)
```powershell
docker rm -f helloworld-app
```

---

## Part 6: Tag Image for ECR (Preparation for next step)

### Step 19: Tag image for AWS ECR
```powershell
# Format: <aws-account-id>.dkr.ecr.<region>.amazonaws.com/<repository-name>:<tag>
docker tag helloworld-springboot:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/helloworld:latest
```
Replace:
- `123456789012` with your AWS account ID
- `us-east-1` with your AWS region
- `helloworld` with your ECR repository name

### Step 20: Verify tagged image
```powershell
docker images | Select-String "helloworld"
```
Should show both `helloworld-springboot:latest` and the ECR-tagged image

---

## Troubleshooting

### Problem: Port 8080 already in use
**Solution 1:** Find and kill the process
```powershell
# Find process
netstat -ano | findstr :8080
# Kill it (replace PID with actual process ID)
taskkill /PID <PID> /F
```

**Solution 2:** Use different port
```powershell
docker run -d -p 9090:8080 --name helloworld-app helloworld-springboot:latest
# Then access at http://localhost:9090/
```

### Problem: Container keeps restarting
```powershell
# Check logs for errors
docker logs helloworld-app
```

### Problem: Can't access the application
1. Verify container is running: `docker ps`
2. Check logs: `docker logs helloworld-app`
3. Verify port mapping: `docker port helloworld-app`
4. Test from inside container: `docker exec helloworld-app wget -qO- http://localhost:8080`

### Problem: Docker build fails
1. Make sure you're in project root directory
2. Verify JAR file exists: `ls 01-spring-boot-app\target\helloworld-1.0.0.jar`
3. Clean build: `docker build --no-cache -t helloworld-springboot:latest .`

### Problem: Out of disk space
```powershell
# Remove unused images
docker image prune -a

# Remove stopped containers
docker container prune

# Remove all unused data
docker system prune -a
```

---

## Complete Workflow Summary

```powershell
# 1. Build Spring Boot app
cd D:\working\Technologies\java-spring-boot-ecs-with-fargate\01-spring-boot-app
mvn clean package

# 2. Build Docker image
cd D:\working\Technologies\java-spring-boot-ecs-with-fargate
docker build -t helloworld-springboot:latest .

# 3. Run container
docker run -d -p 8080:8080 --name helloworld-app helloworld-springboot:latest

# 4. Test
Invoke-WebRequest -Uri http://localhost:8080/ | Select-Object -ExpandProperty Content

# 5. View logs
docker logs helloworld-app

# 6. Stop and remove
docker stop helloworld-app
docker rm helloworld-app
```

---

## Next Steps

After successfully building and testing the Docker image locally:
1. ✅ Spring Boot app built
2. ✅ Docker image created
3. ✅ Container running and tested
4. ➡️ **Next:** Proceed to `03-ecr-publish` to push image to Amazon ECR
5. ➡️ **Then:** Deploy to ECS Fargate (`04-ecs-fargate-deploy`)
