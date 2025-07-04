package model;

import java.util.List;

public class FishSpecies {

    private int id;
    private String commonName;
    private String scientificName;
    private String description;
    private String imageUrl;
    private String bait;
    private String bestSeason;
    private String bestTimeOfDay;
    private String fishingSpots;
    private String fishingTechniques;
    private int difficultyLevel;
    private double averageWeightKg;
    private double length;
    private String habitat;
    private String behavior;
    private String tips;
    private List<String> images;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCommonName() {
        return commonName;
    }

    public void setCommonName(String commonName) {
        this.commonName = commonName;
    }

    public String getScientificName() {
        return scientificName;
    }

    public void setScientificName(String scientificName) {
        this.scientificName = scientificName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getBait() {
        return bait;
    }

    public void setBait(String bait) {
        this.bait = bait;
    }

    public String getBestSeason() {
        return bestSeason;
    }

    public void setBestSeason(String bestSeason) {
        this.bestSeason = bestSeason;
    }

    public String getBestTimeOfDay() {
        return bestTimeOfDay;
    }

    public void setBestTimeOfDay(String bestTimeOfDay) {
        this.bestTimeOfDay = bestTimeOfDay;
    }

    public String getFishingSpots() {
        return fishingSpots;
    }

    public void setFishingSpots(String fishingSpots) {
        this.fishingSpots = fishingSpots;
    }

    public String getFishingTechniques() {
        return fishingTechniques;
    }

    public void setFishingTechniques(String fishingTechniques) {
        this.fishingTechniques = fishingTechniques;
    }

    public int getDifficultyLevel() {
        return difficultyLevel;
    }

    public void setDifficultyLevel(int difficultyLevel) {
        this.difficultyLevel = difficultyLevel;
    }

    public double getAverageWeightKg() {
        return Math.round(averageWeightKg * 10.0) / 10.0;
    }

    public void setAverageWeightKg(double averageWeightKg) {
        this.averageWeightKg = averageWeightKg;
    }

    public double getLength() {
        return Math.round(length * 10.0) / 10.0;
    }

    public void setLength(double length) {
        this.length = length;
    }

    public String getHabitat() {
        return habitat;
    }

    public void setHabitat(String habitat) {
        this.habitat = habitat;
    }

    public String getBehavior() {
        return behavior;
    }

    public void setBehavior(String behavior) {
        this.behavior = behavior;
    }

    public String getTips() {
        return tips;
    }

    public void setTips(String tips) {
        this.tips = tips;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }
}
