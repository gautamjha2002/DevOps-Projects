FROM openjdk:21-oracle
ADD ./target/*.jar /myapp/
WORKDIR /myapp
ENTRYPOINT [ "java", "-jar", "*.jar" ]
EXPOSE 8080