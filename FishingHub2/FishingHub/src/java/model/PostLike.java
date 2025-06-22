package model;
import java.util.Date;

public class PostLike {
    private int postId;
    private int userId;
    private Date likedAt;

    public PostLike() {
    }

    public PostLike(int postId, int userId, Date likedAt) {
        this.postId = postId;
        this.userId = userId;
        this.likedAt = likedAt;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getLikedAt() {
        return likedAt;
    }

    public void setLikedAt(Date likedAt) {
        this.likedAt = likedAt;
    }

    @Override
    public String toString() {
        return "PostLike{" +
                "postId=" + postId +
                ", userId=" + userId +
                ", likedAt=" + likedAt +
                '}';
    }
}
