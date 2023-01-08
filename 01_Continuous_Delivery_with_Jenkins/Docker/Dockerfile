FROM openjdk:21-oracle
COPY /var/lib/jenkins/workspace/test/01_Continuous_Delivery_with_Jenkins/Application/target /myapp/*jar
WORKDIR /myapp
ENTRYPOINT [ "java" "-jar" "*.jar" ]
EXPOSE 8080