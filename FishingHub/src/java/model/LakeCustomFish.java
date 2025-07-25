package model;

public class LakeCustomFish {
    private int customFishId;
    private int lakeId;
    private String fishName;
    private double price;

    public LakeCustomFish() {}

    public LakeCustomFish(int customFishId, int lakeId, String fishName, double price) {
        this.customFishId = customFishId;
        this.lakeId = lakeId;
        this.fishName = fishName;
        this.price = price;
    }

    public int getCustomFishId() {
        return customFishId;
    }

    public void setCustomFishId(int customFishId) {
        this.customFishId = customFishId;
    }

    public int getLakeId() {
        return lakeId;
    }

    public void setLakeId(int lakeId) {
        this.lakeId = lakeId;
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