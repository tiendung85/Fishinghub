package model;

import java.util.Date;

public class CommentLike {
    private int commentId;
    private int userId;
    private Date likedAt;

    public CommentLike() {
    }

    public CommentLike(int commentId, int userId, Date likedAt) {
        this.commentId = commentId;
        this.userId = userId;
        this.likedAt = likedAt;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
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
        return "CommentLike{" +
                "commentId=" + commentId +
                ", userId=" + userId +
                ", likedAt=" + likedAt +
                '}';
    }
}