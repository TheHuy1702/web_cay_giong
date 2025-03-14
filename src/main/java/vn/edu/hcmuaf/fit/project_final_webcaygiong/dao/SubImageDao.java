package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.SubImage;

import java.util.ArrayList;
import java.util.List;

public class SubImageDao {
    List<SubImage> subImageList;

    public SubImageDao() {
        subImageList = new ArrayList<>();
    }

    public List<SubImage> getSubImage(int pid) {
        subImageList = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from subimage where productID=?")
                        .bind(0, pid)
                        .mapToBean(SubImage.class).list());
        return subImageList;
    }

    public static void main(String[] args) {
        SubImageDao subImageDao = new SubImageDao();
        List<SubImage> subImages = subImageDao.getSubImage(1);
        for (SubImage subImage : subImages) {
            System.out.println(subImage);
        }
    }
}
