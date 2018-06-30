FROM openjdk:8
LABEL version 1.1.1
LABEL maintainer "Data Eegineering Awesomeness" 

RUN mkdir /app
WORKDIR /app/

COPY application.yml /app/
COPY shinyproxy-1.1.1.jar /app/

EXPOSE 8080
CMD ["java", "-jar", "/app/shinyproxy-1.1.1.jar" ]