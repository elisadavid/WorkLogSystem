# syntax=docker/dockerfile:1

FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends ant && rm -rf /var/lib/apt/lists/*

COPY . .

RUN ant dist

FROM tomcat:10.1-jdk21-temurin
WORKDIR /usr/local/tomcat

RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

RUN rm -rf webapps/*
COPY --from=build /app/dist/WorkLogSystem.war /usr/local/tomcat/webapps/WorkLogSystem.war
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod +x /usr/local/tomcat/bin/entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/usr/local/tomcat/bin/entrypoint.sh"]
