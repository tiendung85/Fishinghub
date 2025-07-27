package model;

import java.util.Date;

public class PostRejection {
    private int rejectionId;
    private int postId;
    private String reason;
    private Date rejectedAt;

    public int getRejectionId() {
        return rejectionId;
    }

    public void setRejectionId(int rejectionId) {
        this.rejectionId = rejectionId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Date getRejectedAt() {
        return rejectedAt;
    }

    public void setRejectedAt(Date rejectedAt) {
        this.rejectedAt = rejectedAt;
    }
}
