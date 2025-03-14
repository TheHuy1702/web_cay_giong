package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Introduction;

import java.util.ArrayList;
import java.util.List;

public class IntroductionDao {
    List<Introduction> introductionList;

    public IntroductionDao() {
        introductionList = new ArrayList<>();
    }

    public List<Introduction> getIntroduction() {
        introductionList = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from introduction")
                        .mapToBean(Introduction.class).list());
        return introductionList;
    }
    public void updateIntroduction(int introID, String sectionName, String content) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE introduction SET sectionName = ?, content = ? WHERE introID = ?")
                        .bind(0, sectionName)
                        .bind(1,content)
                        .bind(2, introID)
                        .execute());
    }


    public static void main(String[] args) {
        IntroductionDao introductionDao = new IntroductionDao();
        List<Introduction> introductionList1 = introductionDao.getIntroduction();
        for (Introduction introduction : introductionList1) {
            System.out.println(introduction);
        }
    }
}
