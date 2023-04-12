# Use an official Maven image as a parent image
FROM maven:3.8.2-openjdk-11-slim AS build

# Set the working directory to /app
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the Maven dependencies (but don't copy the source code)
RUN mvn dependency:go-offline

# Copy the rest of the source code to the container
COPY src/ ./src/

# Build the application
RUN mvn package

# Use an official OpenJDK image as the base image for the runtime container
FROM openjdk:11-jre-slim

# Set the working directory to /app
WORKDIR /app

# Copy the executable JAR file from the build stage to the runtime container
COPY --from=build /app/target/maven-0.0.1-SNAPSHOT.jar .

# Expose the port that the application listens on
EXPOSE 8080

# Start the application when the container launches
CMD ["java", "-jar", "maven-0.0.1-SNAPSHOT.jar"]

