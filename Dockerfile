FROM maven:3.8.2-openjdk-11

RUN mkdir /java-project

COPY src /java-project/src
COPY pom.xml /java-project

WORKDIR /java-project

RUN mvn clean install

CMD ["java", "-jar", "/java-project/target/my-app-1.0.jar"]

