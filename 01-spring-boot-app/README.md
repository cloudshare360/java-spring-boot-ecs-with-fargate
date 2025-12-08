# 01 - Spring Boot App

## Overview
Simple HelloWorld Spring Boot application built with Java 8 and Spring Boot 2.7.18.

## Technology Stack
- Java 8 (JDK 1.8.0_202)
- Spring Boot 2.7.18
- Maven 3.9+

## Endpoint
- `GET /` - Returns "Hello World from Spring Boot!"
- Server runs on port 8080

## Build and Run

### Build
```bash
mvn clean package
```

### Run locally
```bash
mvn spring-boot:run
# OR
java -jar target/helloworld-1.0.0.jar
```

### Test
```bash
curl http://localhost:8080/
```

## Project Structure
```
src/
├── main/
│   ├── java/com/example/helloworld/
│   │   ├── HelloWorldApplication.java
│   │   └── HelloController.java
│   └── resources/
│       └── application.properties
└── test/
    └── java/com/example/helloworld/
        ├── HelloWorldApplicationTests.java
        └── HelloControllerTest.java
```
