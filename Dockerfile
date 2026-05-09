# Stage 1
FROM maven:3.8.3-openjdk-17 AS build

# Set working directory
WORKDIR /src

# Copy source code from local to container
COPY . /src

# Build application and skip test cases
RUN mvn clean install -DskipTests=true

# Stage 2

# Import small size java image
FROM eclipse-temurin:17-alpine AS deployer

# Copy build from stage 1 (builder)
COPY --from=build /src/target/*.jar /src/target/bankapp.jar

# Expose application port 
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/src/target/bankapp.jar"]
