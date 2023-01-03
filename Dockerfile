FROM openjdk:8-jre-alpine

EXPOSE 8080

COPY ./target/java-maven-app-*.jar /usr/app/
WORKDIR /usr/app

CMD java -jar java-maven-app-*.jar

#Would not be able to turn dynamic because shell commaand will not work with it (contains [...] and strings
#ENTRYPOINT ["java","-jar", "java-maven-app-1.10-SNAPSHOT.jar"]