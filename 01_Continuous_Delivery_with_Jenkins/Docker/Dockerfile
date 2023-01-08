FROM openjdk:21-oracle
COPY ../Application/target/*jar /myapp/
WORKDIR /myapp
ENTRYPOINT [ "java" "-jar" "*.jar" ]
EXPOSE 8080