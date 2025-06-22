package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Post {
    private int postId;
    private int userId;
    private String topic;
    private String title;
    private String content;

    private Date createdAt;
    private String status;
    private List<String> images;
    private List<String> videos;

    public Post() {
        this.images = new ArrayList<>();
        this.videos = new ArrayList<>();
    }

    public Post(int userId, String topic, String title, String content, Date createdAt) {
        this.userId = userId;
        this.topic = topic;
        this.title = title;
        this.content = content;

        this.createdAt = createdAt;
        this.status = status;
    }

    public Post(int postId, int userId, String topic, String title, String content, Date createdAt) {
        this.postId = postId;
        this.userId = userId;
        this.topic = topic;
        this.title = title;
        this.content = content;

        this.createdAt = createdAt;
        this.status = status;
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

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public void addImage(String image) {
        if (this.images == null) {
            this.images = new ArrayList<>();
        }
        this.images.add(image);
    }

    public void addVideo(String videoPath) {
        if (videos == null) {
            videos = new ArrayList<>();
        }
        videos.add(videoPath);
    }

    public List<String> getVideos() {
        return videos;
    }

    public void setVideos(List<String> videos) {
        this.videos = videos;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Post{" + "postId=" + postId + ", userId=" + userId + ", topic=" + topic + ", title=" + title
                + ", content=" + content + ", createdAt=" + createdAt + ", status=" + status + ", images=" + images
                + ", videos=" + videos + '}';
    }

}
