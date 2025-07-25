package dal;

import java.sql.*;
import java.util.*;
import model.Shop;

public class ShopDAO extends DBConnect {

    public List<Shop> getAllShops() {
        List<Shop> list = new ArrayList<>();
        String sql = "SELECT * FROM Shop";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shop s = new Shop();
                s.setShopId(rs.getInt("ShopId"));
                s.setOwnerId(rs.getInt("OwnerId"));
                s.setShopName(rs.getString("ShopName"));
                s.setCreatedAt(rs.getTimestamp("CreatedAt"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
}