FROM openjdk:21-oracle
ADD ./target/*.jar /myapp/
WORKDIR /myapp
ENTRYPOINT [ "java", "-jar", "spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar" ]
EXPOSE 8080