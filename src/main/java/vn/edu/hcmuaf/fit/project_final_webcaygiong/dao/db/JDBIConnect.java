package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.*;

import java.sql.SQLException;
import java.util.List;

public class JDBIConnect {
    static private Jdbi jdbi;
    static String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port() + "/" + DBProperties.dbname() + "?" + DBProperties.option();

    public static Jdbi get() {
        if (jdbi == null) makeConnect();
        return jdbi;
    }

    private static void makeConnect() {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL(url);
        dataSource.setUser(DBProperties.username());
        dataSource.setPassword(DBProperties.password());

        try {
            https:
//github.com/NGUYEN-HOAI-KHUONG/PROJECT-WEB-CAY-GIONG.git
            dataSource.setUseCompression(true);
            dataSource.setAutoReconnect(true);

        } catch (SQLException e) {
            throw new RuntimeException();
        }
        jdbi = Jdbi.create(dataSource);
    }

    public static void main(String[] args) {
        Jdbi jdbi1=get();
        List<Product> products = jdbi1.withHandle(handle ->
            handle.createQuery("select * from products")
                    .mapToBean(Product.class).list());
       for(Product product:products){
           System.out.println(product);
       }

    }
}
