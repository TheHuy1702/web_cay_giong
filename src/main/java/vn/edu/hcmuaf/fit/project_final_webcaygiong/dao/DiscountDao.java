package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Customer;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.Discount;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class DiscountDao {

    public DiscountDao() {
    }

    public List<Discount> getAllDiscounts() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from discounts where deleted = false")
                        .mapToBean(Discount.class).list());
    }

    public List<Discount> getAllDiscountsDeleted() {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from discounts where deleted = true")
                        .mapToBean(Discount.class).list());
    }

    public void addDiscount(Discount discount) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("INSERT INTO discounts (code, description, minOrderValue, startDate, endDate) VALUES (:code, :description, :minOrderValue, :startDate, :endDate)")
                        .bindBean(discount)
                        .execute()
        );
    }

    public void updateDiscount(Discount discount, int id) {
        JDBIConnect.get().useHandle(h ->
                h.createUpdate("UPDATE discounts SET code = :code, description = :description, minOrderValue = :minOrderValue,startDate = :startDate, endDate = :endDate WHERE iD = :iD")
                        .bind("code", discount.getCode())
                        .bind("description", discount.getDescription())
                        .bind("minOrderValue", discount.getMinOrderValue())
                        .bind("startDate", discount.getStartDate())
                        .bind("endDate", discount.getEndDate())
                        .bind("iD", id)
                        .execute()
        );
    }

    public void deleteDiscount(int id) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE discounts SET deleted = true WHERE iD = ?")
                        .bind(0, id)
                        .execute());
    }

    public void redoDiscount(int id) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE discounts SET deleted = false WHERE iD = ?")
                        .bind(0, id)
                        .execute());
    }

    public void deleteDiscountReal(int id) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("DELETE FROM discounts WHERE iD = ?")
                        .bind(0, id)
                        .execute());
    }

    public static void main(String[] args) {
        DiscountDao dao = new DiscountDao();
        dao.deleteDiscount(2);
    }

}
