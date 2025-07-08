package model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Post {
    private int postId;
    private int userId;
    private String topic;
    private String title;
    private String content;

    private Timestamp createdAt;
    private List<String> images;
    private List<String> videos;

    public Post() {
        this.images = new ArrayList<>();
        this.videos = new ArrayList<>();
    }

   

    public Post(int userId, String topic, String title, String content, Timestamp createdAt) {
        this.userId = userId;
        this.topic = topic;
        this.title = title;
        this.content = content;

        this.createdAt = createdAt;
    }

    public Post(int postId, int userId, String topic, String title, String content, Timestamp createdAt) {
        this.postId = postId;
        this.userId = userId;
        this.topic = topic;
        this.title = title;
        this.content = content;

        this.createdAt = createdAt;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
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

    @Override
    public String toString() {
        return "Post{" + "postId=" + postId + ", userId=" + userId + ", topic=" + topic + ", title=" + title
                + ", content=" + content + ", createdAt=" + createdAt + '}';
    }

}
