package model;

import java.util.List;

public class FishingLake {
    private int lakeId;
    private String name;
    private String location;
    private int ownerId;
    private List<String> fishSpeciesNames;
    private List<FishSpecies> fishSpeciesNotInLake; // Thuộc tính mới
    private List<LakeFishInfo> lakeFishInfoList; // Thuộc tính mới

    private List<LakeCustomFish> customFishList;
    // Constructor mặc định
    public FishingLake() {
    }

    // Constructor đầy đủ
    public FishingLake(int lakeId, String name, String location, int ownerId) {
        this.lakeId = lakeId;
        this.name = name;
        this.location = location;
        this.ownerId = ownerId;
    }

    // Getter và Setter
    public int getLakeId() {
        return lakeId;
    }

    public void setLakeId(int lakeId) {
        this.lakeId = lakeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public List<String> getFishSpeciesNames() {
        return fishSpeciesNames;
    }

    public void setFishSpeciesNames(List<String> fishSpeciesNames) {
        this.fishSpeciesNames = fishSpeciesNames;
    }

    public List<FishSpecies> getFishSpeciesNotInLake() {
        return fishSpeciesNotInLake;
    }

    public void setFishSpeciesNotInLake(List<FishSpecies> fishSpeciesNotInLake) {
        this.fishSpeciesNotInLake = fishSpeciesNotInLake;
    }

    public List<LakeFishInfo> getLakeFishInfoList() {
        return lakeFishInfoList;
    }

    public void setLakeFishInfoList(List<LakeFishInfo> lakeFishInfoList) {
        this.lakeFishInfoList = lakeFishInfoList;
    }
    
    public List<LakeCustomFish> getCustomFishList() {
    return customFishList;
}

public void setCustomFishList(List<LakeCustomFish> customFishList) {
    this.customFishList = customFishList;
}
}