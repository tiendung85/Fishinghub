package model;

public class Review {
    private int id;
    private int productId;
    private int rating;
    private String reviewText;
    private String image;
    private String video;

    // Constructors
    public Review() {}

    public Review(int id, int productId, int rating, String reviewText, String image, String video) {
        this.id = id;
        this.productId = productId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.image = image;
        this.video = video;
    }

    // Getters & setters
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
}
