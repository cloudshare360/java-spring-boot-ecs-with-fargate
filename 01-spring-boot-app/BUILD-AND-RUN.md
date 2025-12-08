# Build and Run Guide

## Prerequisites
- Java 8 (JDK 1.8) installed
- Maven 3.6+ installed
- JAVA_HOME environment variable set

## Verify Prerequisites

```bash
# Check Java version
java -version

# Check Maven version
mvn -version
```

## Build Commands

### Clean Build Artifacts
Remove all previously compiled files and build outputs:

```bash
mvn clean
```

### Compile Source Code
Compile Java source files without packaging:

```bash
mvn compile
```

### Package Application
Compile, run tests, and create JAR file:

```bash
mvn package
```

### Full Clean and Package
Clean previous builds and create fresh JAR:

```bash
mvn clean package
```

### Skip Tests (faster build)
Build without running tests:

```bash
mvn clean package -DskipTests
```

## Run Application

### Option 1: Using Maven Spring Boot Plugin
```bash
mvn spring-boot:run
```

### Option 2: Run Packaged JAR
```bash
java -jar target/helloworld-1.0.0.jar
```

### Option 3: Run with Custom Port
```bash
java -jar target/helloworld-1.0.0.jar --server.port=9090
```

### Option 4: Run in Background (Windows)
```powershell
Start-Process java -ArgumentList "-jar","target/helloworld-1.0.0.jar" -WindowStyle Hidden
```

### Option 5: Run in Background (Linux/Mac)
```bash
nohup java -jar target/helloworld-1.0.0.jar > app.log 2>&1 &
```

## Test Application

Once the application is running, test the endpoint:

```bash
# Using curl
curl http://localhost:8080/

# Using PowerShell
Invoke-WebRequest -Uri http://localhost:8080/ | Select-Object -ExpandProperty Content

# Using browser
# Open: http://localhost:8080/
```

Expected response:
```
Hello World from Spring Boot!
```

## Run Tests Only

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=HelloControllerTest

# Run with verbose output
mvn test -X
```

## Common Maven Lifecycle Phases

| Command | Description |
|---------|-------------|
| `mvn clean` | Delete target directory |
| `mvn compile` | Compile source code |
| `mvn test` | Run unit tests |
| `mvn package` | Create JAR file |
| `mvn verify` | Run integration tests |
| `mvn install` | Install to local Maven repository |
| `mvn spring-boot:run` | Run Spring Boot application |

## Complete Build Workflow

```bash
# 1. Clean previous builds
mvn clean

# 2. Compile source code
mvn compile

# 3. Run tests
mvn test

# 4. Package application
mvn package

# 5. Run application
java -jar target/helloworld-1.0.0.jar
```

## Or Simply (All-in-One)

```bash
# Clean, compile, test, package, and run
mvn clean package && java -jar target/helloworld-1.0.0.jar
```

## Troubleshooting

### Application Won't Start
```bash
# Check if port 8080 is already in use (Windows)
netstat -ano | findstr :8080

# Check if port 8080 is already in use (Linux/Mac)
lsof -i :8080

# Kill process using port (Windows)
taskkill /PID <process_id> /F

# Kill process using port (Linux/Mac)
kill -9 <process_id>
```

### Maven Build Fails
```bash
# Clean Maven cache and rebuild
mvn clean install -U

# Run with debug output
mvn clean package -X
```

### Out of Memory
```bash
# Increase Maven memory
set MAVEN_OPTS=-Xmx1024m

# Run JAR with more memory
java -Xmx512m -jar target/helloworld-1.0.0.jar
```

## Build Artifacts Location

After successful build:
- Compiled classes: `target/classes/`
- Test classes: `target/test-classes/`
- JAR file: `target/helloworld-1.0.0.jar`
- Test reports: `target/surefire-reports/`
