# Stage 1: Build WAR bằng Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Deploy WAR lên Tomcat
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat

# Xóa ROOT mặc định
RUN rm -rf webapps/ROOT

# Copy file WAR từ stage build vào Tomcat
COPY --from=build /app/target/Project_Final_WebCayGiong-1.0-SNAPSHOT.war webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
