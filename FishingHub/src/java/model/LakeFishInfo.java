package model;

public class LakeFishInfo {
    private int fishSpeciesId;
    private String fishName;
    private double price;

    public LakeFishInfo(int fishSpeciesId, String fishName, double price) {
        this.fishSpeciesId = fishSpeciesId;
        this.fishName = fishName;
        this.price = price;
    }

    public int getFishSpeciesId() {
        return fishSpeciesId;
    }

    public void setFishSpeciesId(int fishSpeciesId) {
        this.fishSpeciesId = fishSpeciesId;
    }

    public String getFishName() {
        return fishName;
    }

    public void setFishName(String fishName) {
        this.fishName = fishName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
