package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Permission;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.UserPermission;

import java.util.List;
import java.util.StringTokenizer;

public class UserPermissionDao {
    public UserPermissionDao() {
    }

    public List<UserPermission> getAllUserPermissions(int userID) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from userpermissions where userID = ?")
                        .bind(0, userID)
                        .mapToBean(UserPermission.class).list());
    }

    public boolean hasPermission(int userId, int pageID, int permissionID) {
        String sql = "SELECT COUNT(*) FROM userpermissions "+
                "WHERE userID = ? AND pageID = ? AND permissionID = ?";

        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, userId)
                        .bind(1, pageID)
                        .bind(2, permissionID)
                        .mapTo(Integer.class)
                        .one() > 0 // Kiểm tra nếu có quyền
        );
    }

    // xóa quyền người dùng.
    public void deletePermissionsByUserId(int userId) {
        String sql = "DELETE FROM userpermissions WHERE userID = ?";
        JDBIConnect.get().withHandle(handle ->
            handle.createUpdate(sql)
                    .bind(0, userId)
                    .execute()
        );
    }

    // Thêm quyền.
    public void insertUserPermission(UserPermission userPermission) {
            String insertSql = "INSERT INTO userpermissions (userID, pageID, permissionID) VALUES (?, ?, ?) ";
            JDBIConnect.get().withHandle(handle ->
                    handle.createUpdate(insertSql)
                            .bind(0, userPermission.getUserID())
                            .bind(1, userPermission.getPageID())
                            .bind(2, userPermission.getPermissionID())
                            .execute()
            );
    }

    public List<String> getPermissionsByUserId(int userId) {
        String sql = "SELECT p.name AS pageName, perm.name AS permissionName " +
                "FROM userpermissions up " +
                "JOIN pages p ON up.pageID = p.pageID " +
                "JOIN permissions perm ON up.permissionID = perm.permissionID " +
                "WHERE up.userID = ?";

        List<String> permissions = JDBIConnect.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, userId)
                        .map(row -> row.getColumn("pageName", String.class) + "_" + row.getColumn("permissionName", String.class))
                        .list()
        );

        return permissions;
    }


    public static void main(String[] args) {
    }
}
