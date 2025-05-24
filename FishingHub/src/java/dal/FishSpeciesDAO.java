package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.FishSpecies;

public class FishSpeciesDAO extends DBConnect {
    public FishSpeciesDAO() {
        super();
    }

    public List<FishSpecies> getFishSpeciesByPage(int page, int pageSize) throws SQLException {
        List<FishSpecies> list = new ArrayList<>();
        String sql = "SELECT * FROM FishSpecies ORDER BY Id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FishSpecies fish = new FishSpecies();
                fish.setId(rs.getInt("Id"));
                fish.setCommonName(rs.getString("CommonName"));
                fish.setScientificName(rs.getString("ScientificName"));
                fish.setDescription(rs.getString("Description"));
                fish.setImageUrl(rs.getString("ImageUrl"));
                fish.setBait(rs.getString("Bait"));
                fish.setBestSeason(rs.getString("BestSeason"));
                fish.setBestTimeOfDay(rs.getString("BestTimeOfDay"));
                fish.setFishingSpots(rs.getString("FishingSpots"));
                fish.setFishingTechniques(rs.getString("FishingTechniques"));
                fish.setDifficultyLevel(rs.getInt("DifficultyLevel"));
                fish.setAverageWeightKg(rs.getDouble("AverageWeightKg"));
                fish.setLength(rs.getDouble("Length"));
                fish.setHabitat(rs.getString("Habitat"));
                fish.setBehavior(rs.getString("Behavior"));
                fish.setTips(rs.getString("Tips"));
                list.add(fish);
            }
        }
        return list;
    }

    public int getTotalFishSpecies() throws SQLException {
        String sql = "SELECT COUNT(*) FROM FishSpecies";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public FishSpecies getFishById(int id) {
        String sql = "SELECT * FROM FishSpecies WHERE Id = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    FishSpecies fish = new FishSpecies();
                    fish.setId(rs.getInt("Id"));
                    fish.setCommonName(rs.getString("CommonName"));
                    fish.setScientificName(rs.getString("ScientificName"));
                    fish.setDescription(rs.getString("Description"));
                    fish.setImageUrl(rs.getString("ImageUrl"));
                    fish.setBait(rs.getString("Bait"));
                    fish.setBestSeason(rs.getString("BestSeason"));
                    fish.setBestTimeOfDay(rs.getString("BestTimeOfDay"));
                    fish.setFishingSpots(rs.getString("FishingSpots"));
                    fish.setFishingTechniques(rs.getString("FishingTechniques"));
                    fish.setDifficultyLevel(rs.getInt("DifficultyLevel"));
                    fish.setAverageWeightKg(rs.getFloat("AverageWeightKg"));
                    fish.setLength(rs.getFloat("Length"));
                    fish.setHabitat(rs.getString("Habitat"));
                    fish.setBehavior(rs.getString("Behavior"));
                    fish.setTips(rs.getString("Tips"));
                    return fish;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
