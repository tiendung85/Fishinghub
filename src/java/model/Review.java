package model;

import java.util.Date;

public class Review {
    private int id;
    private int productId;
    private int userId;      // Bổ sung dòng này
    private int rating;
    private String reviewText;
    private String image;
    private String video;
    private Date reviewDate;
    private int orderId;

    // Constructor mặc định
    public Review() {
    }

    // Constructor đầy đủ (tùy chọn)
    public Review(int id, int productId, int userId, int rating, String reviewText, String image, String video,Date reviewDate) {
        this.id = id;
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.image = image;
        this.video = video;
        this.reviewDate=this.reviewDate;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRating() {
        return rating;
    }
    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }
    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getVideo() {
        return video;
    }
    public void setVideo(String video) {
        this.video = video;
    }
       public Date getReviewDate() { // Thêm hàm này
        return reviewDate;
    }
    public void setReviewDate(Date reviewDate) { // Thêm hàm này
        this.reviewDate = reviewDate;
    }
    public int getOrderId() {
    return orderId;
}

public void setOrderId(int orderId) {
    this.orderId = orderId;
}

}
