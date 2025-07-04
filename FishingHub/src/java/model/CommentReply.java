package model;

import java.util.Date;

public class CommentReply {
    private int replyId;
    private int commentId;
    private int userId;
    private String content;
    private Date createdAt;
    // private int parentReplyId;

    public CommentReply() {
    }

    public CommentReply(int replyId, int commentId, int userId, String content, Date createdAt) {
        this.replyId = replyId;
        this.commentId = commentId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
        // this.parentReplyId = parentReplyId;
    }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CommentReply{" + "replyId=" + replyId + ", commentId=" + commentId + ", userId=" + userId + ", content=" + content + ", createdAt=" + createdAt + '}';
    }

   
   
}