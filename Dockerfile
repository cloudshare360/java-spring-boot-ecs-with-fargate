# Use Eclipse Temurin Java 8 base image (replaces deprecated openjdk)
FROM eclipse-temurin:8-jre-alpine

# Set working directory
WORKDIR /app

# Copy the JAR file from the build output
COPY 01-spring-boot-app/target/helloworld-1.0.0.jar app.jar

# Expose the application port
EXPOSE 8080

# Set JVM options (optional)
ENV JAVA_OPTS="-Xmx256m -Xms128m"

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
