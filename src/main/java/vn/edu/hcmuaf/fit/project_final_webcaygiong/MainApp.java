package vn.edu.hcmuaf.fit.project_final_webcaygiong;

import org.apache.catalina.startup.Tomcat;

public class MainApp {
    public static void main(String[] args) throws Exception {
        // Lấy port từ biến môi trường (Render sẽ set PORT)
        String port = System.getenv("PORT");
        if (port == null) {
            port = "8080"; // chạy local mặc định
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));

        // Đường dẫn đến thư mục chứa file JSP/Servlet (webapp)
        String webappDirLocation = "src/main/webapp/";

        tomcat.addWebapp("", new java.io.File(webappDirLocation).getAbsolutePath());

        System.out.println("Starting Tomcat on port: " + port);
        tomcat.start();
        tomcat.getServer().await();
    }
}
