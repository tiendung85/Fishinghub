package model;

import java.sql.Date;

public class Achievement {
    private int achievementId;
    private int userId;
    private int fishId;
    private String image;
    private String description;
    private Date dateAchieved;
    private int points; // Nếu có trường điểm

    public Achievement() {}

    public Achievement(int achievementId, int userId, int fishId, String image, String description, Date dateAchieved, int points) {
        this.achievementId = achievementId;
        this.userId = userId;
        this.fishId = fishId;
        this.image = image;
        this.description = description;
        this.dateAchieved = dateAchieved;
        this.points = points;
    }

    // Getter, Setter
    public int getAchievementId() { return achievementId; }
    public void setAchievementId(int achievementId) { this.achievementId = achievementId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getFishId() { return fishId; }
    public void setFishId(int fishId) { this.fishId = fishId; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getDateAchieved() { return dateAchieved; }
    public void setDateAchieved(Date dateAchieved) { this.dateAchieved = dateAchieved; }
    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }
}
