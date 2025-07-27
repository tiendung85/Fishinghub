package model;

import java.sql.Timestamp;

public class NotificationDTO {
    private int id;
    private String type;
    private String message;
    private boolean isRead;
    private Timestamp createdAt;

    public NotificationDTO(int id, String type, String message, boolean isRead, Timestamp createdAt) {
        this.id = id;
        this.type = type;
        this.message = message;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "NotificationDTO{" + "id=" + id + ", type=" + type + ", message=" + message + ", isRead=" + isRead
                + ", createdAt=" + createdAt + '}';
    }

}
