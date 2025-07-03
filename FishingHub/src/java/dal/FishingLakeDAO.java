package dal;

import model.FishingLake;
import model.LakeFishInfo;
import java.sql.*;

import java.util.ArrayList;
import java.util.List;

public class FishingLakeDAO extends DBConnect {

    public FishingLakeDAO() {
        super();
    }

    public List<FishingLake> getLakesByOwnerId(int ownerId) throws SQLException {
        List<FishingLake> lakes = new ArrayList<>();
        String sql = "SELECT LakeId, Name, Location FROM FishingLake WHERE OwnerId = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, ownerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                FishingLake lake = new FishingLake();
                lake.setLakeId(rs.getInt("LakeId"));
                lake.setName(rs.getString("Name"));
                lake.setLocation(rs.getString("Location"));
                lake.setOwnerId(ownerId);
                lakes.add(lake);
            }
        }

        return lakes;
    }

    public List<String> getFishSpeciesNamesByLakeId(int lakeId) throws SQLException {
        List<String> speciesNames = new ArrayList<>();
        String sql = "SELECT fs.CommonName FROM FishSpecies fs " +
                "JOIN LakeFish lf ON fs.Id = lf.FishSpeciesId " +
                "WHERE lf.LakeId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lakeId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                speciesNames.add(rs.getString("CommonName"));
            }
        }
        return speciesNames;
    }

    // Thêm hồ mới, trả về LakeId vừa tạo
    public int createLake(String name, String location, int ownerId) throws SQLException {
        String sql = "INSERT INTO FishingLake (Name, Location, OwnerId) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, name);
            stmt.setString(2, location);
            stmt.setInt(3, ownerId);
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        throw new SQLException("Tạo hồ câu mới thất bại!");
    }

    // Thêm nhiều loài cá vào hồ (có giá)
    public void addFishToLake(int lakeId, List<Integer> fishSpeciesIds, List<Double> prices) throws SQLException {
        String sql = "INSERT INTO LakeFish (LakeId, FishSpeciesId, Price) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < fishSpeciesIds.size(); i++) {
                stmt.setInt(1, lakeId);
                stmt.setInt(2, fishSpeciesIds.get(i));
                stmt.setDouble(3, prices.get(i));
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    // Xóa toàn bộ cá khỏi hồ
    public void removeAllFishFromLake(int lakeId) throws SQLException {
        String sql = "DELETE FROM LakeFish WHERE LakeId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lakeId);
            stmt.executeUpdate();
        }
    }

    // Sửa thông tin hồ
    public void updateLake(int lakeId, String name, String location) throws SQLException {
        String sql = "UPDATE FishingLake SET Name = ?, Location = ? WHERE LakeId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, location);
            stmt.setInt(3, lakeId);
            stmt.executeUpdate();
        }
    }

    // Xóa hồ câu
    public void deleteLake(int lakeId) throws SQLException {
        // Xóa cá trước, rồi xóa hồ
        removeAllFishFromLake(lakeId);
        String sql = "DELETE FROM FishingLake WHERE LakeId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lakeId);
            stmt.executeUpdate();
        }
    }

    // Lấy danh sách loài cá chưa có trong hồ
    public List<model.FishSpecies> getFishSpeciesNotInLake(int lakeId) throws SQLException {
        List<model.FishSpecies> list = new ArrayList<>();
        String sql = "SELECT * FROM FishSpecies WHERE Id NOT IN (SELECT FishSpeciesId FROM LakeFish WHERE LakeId = ?) ORDER BY Id";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lakeId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                model.FishSpecies fish = new model.FishSpecies();
                fish.setId(rs.getInt("Id"));
                fish.setCommonName(rs.getString("CommonName"));
                fish.setScientificName(rs.getString("ScientificName"));
                fish.setDescription(rs.getString("Description"));
                // Có thể bổ sung các trường khác nếu cần
                list.add(fish);
            }
        }
        return list;
    }

    // Lấy danh sách cá và giá tiền cho từng hồ
    public List<LakeFishInfo> getLakeFishInfoList(int lakeId) throws SQLException {
        List<LakeFishInfo> list = new ArrayList<>();
        String sql = "SELECT fs.Id, fs.CommonName, lf.Price " +
                "FROM LakeFish lf " +
                "JOIN FishSpecies fs ON lf.FishSpeciesId = fs.Id " +
                "WHERE lf.LakeId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lakeId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int fishId = rs.getInt("Id");
                    String fishName = rs.getString("CommonName");
                    double price = rs.getDouble("Price");
                    list.add(new LakeFishInfo(fishId, fishName, price));
                }
            }
        }
        return list;
    }

    // Lấy giá của 1 loài cá trong hồ
    public Double getPrice(int lakeId, int fishSpeciesId) throws SQLException {
        String sql = "SELECT Price FROM LakeFish WHERE LakeId = ? AND FishSpeciesId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, lakeId);
            stmt.setInt(2, fishSpeciesId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("Price");
                }
            }
        }
        return null; // hoặc có thể trả về 0 nếu muốn
    }
}