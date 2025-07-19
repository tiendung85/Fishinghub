package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;

public class OrderDetailDAO extends DBConnect {

    public OrderDetailDAO() { super(); }

    public boolean createDetail(OrderDetail detail) {
        String sql = "INSERT INTO OrderDetail (OrderId, ProductId, CartQuantity, Price, Subtotal) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getProductId());
            ps.setInt(3, detail.getCartQuantity());
            ps.setDouble(4, detail.getPrice());
            ps.setDouble(5, detail.getSubtotal());
            int rs = ps.executeUpdate();
            return rs > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<OrderDetail> getDetailByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetail WHERE OrderId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setId(rs.getInt("Id"));
                detail.setOrderId(rs.getInt("OrderId"));
                detail.setProductId(rs.getInt("ProductId"));
                detail.setCartQuantity(rs.getInt("CartQuantity"));
                detail.setPrice(rs.getDouble("Price"));
                detail.setSubtotal(rs.getDouble("Subtotal"));
                orderDetails.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
}
