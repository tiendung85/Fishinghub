package model;

import java.util.Date;

public class ReplyLike {
    private int replyId;
    private int userId;
    private Date likedAt;

    public ReplyLike() {
    }

    public ReplyLike(int replyId, int userId, Date likedAt) {
        this.replyId = replyId;
        this.userId = userId;
        this.likedAt = likedAt;
    }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
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
        return "ReplyLike{" +
                "replyId=" + replyId +
                ", userId=" + userId +
                ", likedAt=" + likedAt +
                '}';
    }
}
