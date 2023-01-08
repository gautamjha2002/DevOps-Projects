FROM openjdk:21-oracle
COPY 01_Continuous_Delivery_with_Jenkins/Application/target /myapp/
WORKDIR /myapp
ENTRYPOINT [ "java" "-jar" "*.jar" ]
EXPOSE 8080