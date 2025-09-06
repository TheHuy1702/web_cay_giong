# Sử dụng Tomcat chính thức
FROM tomcat:9.0-jdk17

# Xóa app mặc định ROOT
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy file .war từ target/ vào Tomcat
COPY target/Project_Final_WebCayGiong-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Mở port 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
