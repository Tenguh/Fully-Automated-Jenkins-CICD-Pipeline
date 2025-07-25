FROM openjdk:8-jre-alpine

EXPOSE 8080

WORKDIR /usr/app

COPY ./target/java-maven-app-*.jar ./app.jar

CMD ["java", "-jar", "app.jar"]

