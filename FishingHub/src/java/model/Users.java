package model;

public class Users {
    private String fullName;
    private String email;
    private String password;
    private String fishingSkillLevel;
    private boolean termsAccepted;

    public Users() {}

    public Users(String fullName, String email, String password, String fishingSkillLevel, boolean termsAccepted) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.fishingSkillLevel = fishingSkillLevel;
        this.termsAccepted = termsAccepted;
    }

    // getter và setter
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFishingSkillLevel() { return fishingSkillLevel; }
    public void setFishingSkillLevel(String fishingSkillLevel) { this.fishingSkillLevel = fishingSkillLevel; }

    public boolean isTermsAccepted() { return termsAccepted; }
    public void setTermsAccepted(boolean termsAccepted) { this.termsAccepted = termsAccepted; }
}
