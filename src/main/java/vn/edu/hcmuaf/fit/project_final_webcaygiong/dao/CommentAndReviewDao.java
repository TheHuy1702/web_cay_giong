package vn.edu.hcmuaf.fit.project_final_webcaygiong.dao;

import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.db.JDBIConnect;
import vn.edu.hcmuaf.fit.project_final_webcaygiong.dao.model.CommentAndReview;

import java.util.ArrayList;
import java.util.List;

public class CommentAndReviewDao {
    List<CommentAndReview> commentAndReview;

    public CommentAndReviewDao() {
        commentAndReview = new ArrayList<>();
    }

    // lấy ra tất cả comment và đánh giá.
    public List<CommentAndReview> getAllCommentAndReview() {
        commentAndReview = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from commentandreviews where deleted = false")
                        .mapToBean(CommentAndReview.class).list());
        return commentAndReview;
    }

    public CommentAndReview getCommentAndReview(int id) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from commentandreviews where comAndReID = ?")
                        .bind(0, id)
                        .mapToBean(CommentAndReview.class).one());
    }

    // lấy ra tất cả comment và đánh giá của sản phẩm nhất định.
    public List<CommentAndReview> getAllCommentOfProduct(int productID) {
        commentAndReview = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from commentandreviews where productID=? and deleted=false order by comAndReID desc")
                        .bind(0, productID)
                        .mapToBean(CommentAndReview.class).list());
        return commentAndReview;
    }

    public List<CommentAndReview> getAllCommentAndReviewDeleted() {
        commentAndReview = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("select * from commentandreviews where deleted = true")
                        .mapToBean(CommentAndReview.class).list());
        return commentAndReview;
    }

    // thêm comment and reviews.
    public void addCommentAndReview(CommentAndReview comment) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("INSERT INTO commentandreviews (userID, name, productID, content, ratingStars) VALUES (?, ?, ?, ?, ?)")
                        .bind(0, comment.getUserID())
                        .bind(1, comment.getName())
                        .bind(2, comment.getProductID())
                        .bind(3, comment.getContent())
                        .bind(4, comment.getRatingStars())
                        .execute());
    }

    // thêm phương thức xóa comment and reviews.
    public void deleteCommentAndReview(int comAndReID) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE commentandreviews SET deleted = true WHERE comAndReID = ?")
                        .bind(0, comAndReID)
                        .execute());
    }

    public void redoCommentAndReview(int commentIdHis) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("UPDATE commentandreviews SET deleted = false WHERE comAndReID = ?")
                        .bind(0, commentIdHis)
                        .execute());
    }

    public void deleteCommentAndReviewReal(int id) {
        JDBIConnect.get().withHandle(handle ->
                handle.createUpdate("DELETE FROM commentandreviews WHERE comAndReID = ?")
                        .bind(0, id)
                        .execute());
    }

    // lấy comment and review theo tên.
    public List<CommentAndReview> getAllCommentOfProductByName(String productName) {
        // Lấy tất cả ID sản phẩm dựa trên tên sản phẩm
        List<Integer> productIds = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT productID FROM products WHERE name LIKE ?")
                        .bind(0, "%" + productName + "%")
                        .mapTo(Integer.class)
                        .list());

        // Nếu không tìm thấy sản phẩm nào, trả về danh sách rỗng
        if (productIds.isEmpty()) {
            return new ArrayList<>();
        }

        // Lấy tất cả bình luận cho tất cả các sản phẩm có ID đã tìm thấy
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM commentandreviews WHERE productID IN (<productIds>)")
                        .bindList("productIds", productIds)
                        .mapToBean(CommentAndReview.class).list());
    }

    // lấy comment and review theo điểm đánh giá và id sản phẩm.
    public List<CommentAndReview> getAllCommentOfProductByRatingAndIDP(int productID, int ratingStars) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM commentandreviews WHERE productID = ? AND ratingStars = ? and deleted=false")
                        .bind(0, productID)
                        .bind(1, ratingStars)
                        .mapToBean(CommentAndReview.class).list());
    }

    // lấy comment and review theo điểm đánh giá.
    public List<CommentAndReview> getAllCommentOfProductByRating(int ratingStars) {
        return JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT * FROM commentandreviews WHERE ratingStars = ? and deleted = false")
                        .bind(0, ratingStars)
                        .mapToBean(CommentAndReview.class).list());
    }

    public double trungBinhSoSao(int productID) {
        Double average = JDBIConnect.get().withHandle(handle ->
                handle.createQuery("SELECT AVG(ratingStars) FROM commentandreviews WHERE productID = ?")
                        .bind(0, productID)
                        .mapTo(Double.class)
                        .one());
        return average != null ? Math.round(average * 100.0) / 100.0 : 5;
    }


    public static void main(String[] args) {
        CommentAndReviewDao commentAndReviewDao = new CommentAndReviewDao();
        List<CommentAndReview> commentAndReviews = commentAndReviewDao.getAllCommentOfProduct(2);
        for (CommentAndReview commentAndReview : commentAndReviews) {
            System.out.println(commentAndReview);
        }

        List<CommentAndReview> comments = commentAndReviewDao.getAllCommentAndReview();
        for (CommentAndReview commentAndReview : comments) {
            System.out.println(commentAndReview);
        }
        commentAndReviewDao.deleteCommentAndReview(4);
        System.out.println("\n");
        for (CommentAndReview commentAndReview : commentAndReviewDao.getAllCommentOfProductByRating(5)) {
            System.out.println(commentAndReview);
        }
        System.out.println(commentAndReviewDao.trungBinhSoSao(2));
        CommentAndReview c = commentAndReviewDao.getCommentAndReview(1);
        System.out.println(c);
        commentAndReviewDao.deleteCommentAndReview(1);
    }
}
