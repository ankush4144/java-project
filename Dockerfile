# Using openjdk image to run .jar file 
FROM openjdk:8-jdk-slim

# copying jar from target directory to container
COPY target/*.jar /tmp/my-app.jar

# Setting work directory
WORKDIR /tmp

# Setting up command to run while running container
CMD ["java", "-jar", "app.jar"]
