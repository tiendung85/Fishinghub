/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;

public class OrderDetailDAO extends DBConnect {

    public OrderDetailDAO() {
        super();
    }

    public boolean createDetail(OrderDetail detail) {
        String sql = "insert into OrderDetail ( OrderId, ProductId, CartQuantity, Price) "
                + "VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, detail.getOrderId());
            ps.setInt(2, detail.getProductId());
            ps.setInt(3, detail.getCartQuantity());
            ps.setDouble(4, detail.getPrice());
            int rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<OrderDetail> getDetailByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "select * from OrderDetail where OrderId = ?";
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
                detail.setPrice(rs.getInt("Price"));
                detail.setSubtotal(rs.getInt("Subtotal"));

                orderDetails.add(detail);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
}
