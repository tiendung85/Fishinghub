package dal;

import java.sql.*;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import model.FishSpecies;

public class FishSpeciesDAO extends DBConnect {

    public FishSpeciesDAO() {
        super();
    }

    private String getMainImageByFishSpeciesId(int fishSpeciesId) throws SQLException {
        String sql = "SELECT ImageUrl FROM FishSpeciesImages WHERE FishSpeciesId = ? AND IsMain = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fishSpeciesId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("ImageUrl");
            }
        }
        return null;
    }

    // Cập nhật một ảnh riêng lẻ dựa trên ImageUrl
    public void updateSingleImage(int fishId, String oldImageUrl, String newImageUrl, boolean isMain) throws SQLException {
        if (oldImageUrl != null) {
            String sql = "UPDATE dbo.FishSpeciesImages SET ImageUrl = ?, IsMain = ? WHERE FishSpeciesId = ? AND ImageUrl = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, newImageUrl);
                ps.setBoolean(2, isMain);
                ps.setInt(3, fishId);
                ps.setString(4, oldImageUrl);
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    return;
                }
            }
        }
        // Nếu không tìm thấy ảnh cũ hoặc oldImageUrl là null, chèn ảnh mới
        String sql = "INSERT INTO dbo.FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fishId);
            ps.setString(2, newImageUrl);
            ps.setBoolean(3, isMain);
            ps.executeUpdate();
        }
    }

    public List<String> getImagesByFishSpeciesId(int fishId) throws SQLException {
        List<String> images = new ArrayList<>();
        String sql = "SELECT ImageUrl FROM dbo.FishSpeciesImages WHERE FishSpeciesId = ? ORDER BY IsMain DESC, Id";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fishId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    images.add(rs.getString("ImageUrl"));
                }
            }
        }
        return images;
    }

    // Cập nhật danh sách ảnh
    public void updateImagesForFish(int fishId, List<String> imageUrls, int mainImageIndex) throws SQLException {
        // Xóa ảnh cũ
        String deleteSql = "DELETE FROM dbo.FishSpeciesImages WHERE FishSpeciesId = ?";
        try (PreparedStatement ps = connection.prepareStatement(deleteSql)) {
            ps.setInt(1, fishId);
            ps.executeUpdate();
        }
        // Chèn ảnh mới
        if (!imageUrls.isEmpty()) {
            insertImagesForFish(fishId, imageUrls, mainImageIndex);
        }
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
                // Lấy ảnh chính từ bảng images
                fish.setImageUrl(getMainImageByFishSpeciesId(fish.getId()));
                fish.setBait(rs.getString("Bait"));
                fish.setBestSeason(rs.getString("BestSeason"));
                fish.setBestTimeOfDay(rs.getString("BestTimeOfDay"));
                fish.setFishingSpots(rs.getString("FishingSpots"));
                fish.setFishingTechniques(rs.getString("FishingTechniques"));
                fish.setDifficultyLevel(rs.getInt("DifficultyLevel"));
                fish.setAverageWeightKg(rs.getDouble("AverageWeightKg"));
                fish.setLength(rs.getDouble("AverageLengthCm"));
                fish.setHabitat(rs.getString("Habitat"));
                fish.setBehavior(rs.getString("Behavior"));
                fish.setTips(rs.getString("Tips"));
                // Lấy danh sách ảnh (bổ sung dòng này)
                fish.setImages(getImagesByFishSpeciesId(fish.getId()));
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
                    // Lấy ảnh chính từ bảng images
                    fish.setImageUrl(getMainImageByFishSpeciesId(fish.getId()));
                    fish.setBait(rs.getString("Bait"));
                    fish.setBestSeason(rs.getString("BestSeason"));
                    fish.setBestTimeOfDay(rs.getString("BestTimeOfDay"));
                    fish.setFishingSpots(rs.getString("FishingSpots"));
                    fish.setFishingTechniques(rs.getString("FishingTechniques"));
                    fish.setDifficultyLevel(rs.getInt("DifficultyLevel"));
                    fish.setAverageWeightKg(rs.getFloat("AverageWeightKg"));
                    fish.setLength(rs.getFloat("AverageLengthCm"));
                    fish.setHabitat(rs.getString("Habitat"));
                    fish.setBehavior(rs.getString("Behavior"));
                    fish.setTips(rs.getString("Tips"));
                    // Lấy danh sách ảnh
                    fish.setImages(getImagesByFishSpeciesId(fish.getId()));
                    return fish;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy toàn bộ cá (không phân trang)
    public List<FishSpecies> getAllFishSpecies() throws SQLException {
        List<FishSpecies> list = new ArrayList<>();
        String sql = "SELECT * FROM FishSpecies ORDER BY Id";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FishSpecies fish = new FishSpecies();
                fish.setId(rs.getInt("Id"));
                fish.setCommonName(rs.getString("CommonName"));
                fish.setScientificName(rs.getString("ScientificName"));
                fish.setDescription(rs.getString("Description"));
                fish.setImageUrl(getMainImageByFishSpeciesId(fish.getId()));
                fish.setBait(rs.getString("Bait"));
                fish.setBestSeason(rs.getString("BestSeason"));
                fish.setBestTimeOfDay(rs.getString("BestTimeOfDay"));
                fish.setFishingSpots(rs.getString("FishingSpots"));
                fish.setFishingTechniques(rs.getString("FishingTechniques"));
                fish.setDifficultyLevel(rs.getInt("DifficultyLevel"));
                fish.setAverageWeightKg(rs.getDouble("AverageWeightKg"));
                fish.setLength(rs.getDouble("AverageLengthCm"));
                fish.setHabitat(rs.getString("Habitat"));
                fish.setBehavior(rs.getString("Behavior"));
                fish.setTips(rs.getString("Tips"));
                fish.setImages(getImagesByFishSpeciesId(fish.getId()));
                list.add(fish);
            }
        }
        return list;
    }

    // Lấy cá theo độ khó (1 hoặc nhiều mức độ)
    public List<FishSpecies> getFishByDifficulty(int... difficulties) throws SQLException {
        if (difficulties == null || difficulties.length == 0) {
            return Collections.emptyList();
        }
        List<FishSpecies> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM FishSpecies WHERE DifficultyLevel IN (");
        for (int i = 0; i < difficulties.length; i++) {
            sql.append("?");
            if (i < difficulties.length - 1) {
                sql.append(",");
            }
        }
        sql.append(") ORDER BY Id");
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < difficulties.length; i++) {
                ps.setInt(i + 1, difficulties[i]);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                FishSpecies fish = new FishSpecies();
                fish.setId(rs.getInt("Id"));
                fish.setCommonName(rs.getString("CommonName"));
                fish.setScientificName(rs.getString("ScientificName"));
                fish.setDescription(rs.getString("Description"));
                fish.setImageUrl(getMainImageByFishSpeciesId(fish.getId()));
                fish.setBait(rs.getString("Bait"));
                fish.setBestSeason(rs.getString("BestSeason"));
                fish.setBestTimeOfDay(rs.getString("BestTimeOfDay"));
                fish.setFishingSpots(rs.getString("FishingSpots"));
                fish.setFishingTechniques(rs.getString("FishingTechniques"));
                fish.setDifficultyLevel(rs.getInt("DifficultyLevel"));
                fish.setAverageWeightKg(rs.getDouble("AverageWeightKg"));
                fish.setLength(rs.getDouble("AverageLengthCm"));
                fish.setHabitat(rs.getString("Habitat"));
                fish.setBehavior(rs.getString("Behavior"));
                fish.setTips(rs.getString("Tips"));
                fish.setImages(getImagesByFishSpeciesId(fish.getId()));
                list.add(fish);
            }
        }
        return list;
    }

    // Thêm mới loài cá
    public void addFishSpecies(FishSpecies fish) throws SQLException {
        String sql = "INSERT INTO dbo.FishSpecies (CommonName, ScientificName, Description, Bait, BestSeason, BestTimeOfDay, FishingSpots, FishingTechniques, DifficultyLevel, AverageWeightKg, AverageLengthCm, Habitat, Behavior, Tips) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, fish.getCommonName());
            ps.setString(2, fish.getScientificName());
            ps.setString(3, fish.getDescription());
            ps.setString(4, fish.getBait());
            ps.setString(5, fish.getBestSeason());
            ps.setString(6, fish.getBestTimeOfDay());
            ps.setString(7, fish.getFishingSpots());
            ps.setString(8, fish.getFishingTechniques());
            ps.setInt(9, fish.getDifficultyLevel());
            ps.setDouble(10, fish.getAverageWeightKg());
            ps.setDouble(11, fish.getLength());
            ps.setString(12, fish.getHabitat());
            ps.setString(13, fish.getBehavior());
            ps.setString(14, fish.getTips());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    fish.setId(rs.getInt(1));
                }
            }
        }

    }

    // Cập nhật loài cá
    public void updateFishSpecies(FishSpecies fish) throws SQLException {
        String sql = "UPDATE dbo.FishSpecies SET CommonName = ?, ScientificName = ?, Description = ?, Bait = ?, BestSeason = ?, BestTimeOfDay = ?, FishingSpots = ?, FishingTechniques = ?, DifficultyLevel = ?, AverageWeightKg = ?, AverageLengthCm = ?, Habitat = ?, Behavior = ?, Tips = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fish.getCommonName());
            ps.setString(2, fish.getScientificName());
            ps.setString(3, fish.getDescription());
            ps.setString(4, fish.getBait());
            ps.setString(5, fish.getBestSeason());
            ps.setString(6, fish.getBestTimeOfDay());
            ps.setString(7, fish.getFishingSpots());
            ps.setString(8, fish.getFishingTechniques());
            ps.setInt(9, fish.getDifficultyLevel());
            ps.setDouble(10, fish.getAverageWeightKg());
            ps.setDouble(11, fish.getLength());
            ps.setString(12, fish.getHabitat());
            ps.setString(13, fish.getBehavior());
            ps.setString(14, fish.getTips());
            ps.setInt(15, fish.getId());
            ps.executeUpdate();
        }
    }

    // Xóa loài cá theo id
    public void deleteFishSpecies(int id) throws SQLException {
        String sql = "DELETE FROM FishSpecies WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // Xóa toàn bộ ảnh của 1 loài cá
    public void deleteAllImagesOfFish(int fishSpeciesId) throws SQLException {
        String sql = "DELETE FROM FishSpeciesImages WHERE FishSpeciesId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fishSpeciesId);
            ps.executeUpdate();
        }
    }

    // Chèn danh sách ảnh
    public void insertImagesForFish(int fishId, List<String> imageUrls, int mainImageIndex) throws SQLException {
        String sql = "INSERT INTO dbo.FishSpeciesImages (FishSpeciesId, ImageUrl, IsMain) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (int i = 0; i < imageUrls.size(); i++) {
                ps.setInt(1, fishId);
                ps.setString(2, imageUrls.get(i));
                ps.setBoolean(3, i == mainImageIndex);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

}
// Không cần thay đổi, chỉ cần dữ liệu DB đúng đường dẫn /assets/img/...
