FROM maven:3.6.0-jdk-11-slim AS build

ARG APP_PORT=8080
ENV PORT=$APP_PORT

COPY src /home/app/src

RUN cat /home/app/src/main/resources/application.properties

COPY pom.xml /home/app

RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/backend-0.0.1-SNAPSHOT.jar /usr/local/lib/test.jar

EXPOSE ${APP_PORT}
ENTRYPOINT ["java","-jar","/usr/local/lib/test.jar"]