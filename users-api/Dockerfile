# Stage 1: Build with Maven  
FROM bellsoft/liberica-runtime-container:jdk-21-stream-musl AS builder  
WORKDIR /home/app  
COPY pom.xml mvnw ./
COPY .mvn .mvn
RUN ./mvnw dependency:go-offline -B  

COPY src src
RUN ./mvnw -Dmaven.test.skip=true clean package -B  

# Stage 2: Runtime  
FROM bellsoft/liberica-runtime-container:jre-21-musl  
WORKDIR /home/app  
EXPOSE 8080  
COPY --from=builder /home/app/target/*.jar app.jar  
ENTRYPOINT ["java","-jar","/home/app/app.jar"]
