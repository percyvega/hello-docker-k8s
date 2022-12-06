FROM maven:3.5-jdk-8 as BUILD

COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn -Dmaven.repo.local=./repository package

FROM openjdk:8-jre
EXPOSE 8080 5005
COPY --from=BUILD /usr/src/app/target /opt/target
WORKDIR /opt/target
ENV _JAVA_OPTIONS '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005'

CMD ["java", "-jar", "hello-docker-k8s.war"]
