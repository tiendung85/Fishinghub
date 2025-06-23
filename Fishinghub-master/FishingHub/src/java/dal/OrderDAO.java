package dal;

import java.sql.*;
import java.util.*;
import model.Order;
import model.Status;

public class OrderDAO extends DBConnect {
    public OrderDAO(){
        super();
    }
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.Id, u.FullName, o.OrderDate, o.Subtotal, o.Total, o.StatusID, s.StatusName " +
                     "FROM Orders o " +
                     "JOIN Users u ON o.UserId = u.UserId " +
                     "JOIN OrderStatus s ON o.StatusID = s.StatusID " +
                     "ORDER BY o.OrderDate DESC";
        try (
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("Id"));
                o.setCustomerName(rs.getString("FullName"));
                o.setOrderDate(rs.getTimestamp("OrderDate"));
                o.setSubtotal(rs.getDouble("Subtotal"));
                o.setTotal(rs.getDouble("Total"));
                Status status = new Status();
                status.setStatusID(rs.getInt("StatusID"));
                status.setStatusName(rs.getString("StatusName"));
                o.setStatus(status);
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Status> getAllStatuses() {
        List<Status> list = new ArrayList<>();
        String sql = "SELECT StatusID, StatusName FROM OrderStatus ORDER BY StatusID";
        try (
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                Status s = new Status();
                s.setStatusID(rs.getInt("StatusID"));
                s.setStatusName(rs.getString("StatusName"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateOrderStatus(int orderId, int statusId) {
        System.out.println("[DEBUG] updateOrderStatus called with orderId=" + orderId + ", statusId=" + statusId);
        String sql = "UPDATE Orders SET StatusID = ? WHERE Id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, statusId);
            ps.setInt(2, orderId);
            int rows = ps.executeUpdate();
            System.out.println("[DEBUG] Rows updated: " + rows);
            return rows > 0;
        } catch (Exception e) {
            System.out.println("[ERROR] Failed to update order status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Order> getOrdersByPage(int page, int pageSize) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.Id, u.FullName, o.OrderDate, o.Subtotal, o.Total, o.StatusID, s.StatusName " +
                "FROM Orders o " +
                "JOIN Users u ON o.UserId = u.UserId " +
                "JOIN OrderStatus s ON o.StatusID = s.StatusID " +
                "ORDER BY o.OrderDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("Id"));
                o.setCustomerName(rs.getString("FullName"));
                o.setOrderDate(rs.getTimestamp("OrderDate"));
                o.setSubtotal(rs.getDouble("Subtotal"));
                o.setTotal(rs.getDouble("Total"));
                Status status = new Status();
                status.setStatusID(rs.getInt("StatusID"));
                status.setStatusName(rs.getString("StatusName"));
                o.setStatus(status);
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

               public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> searchOrders(String status, String keyword) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT o.Id, u.FullName, o.OrderDate, o.Subtotal, o.Total, o.StatusID, s.StatusName " +
                "FROM Orders o " +
                "JOIN Users u ON o.UserId = u.UserId " +
                "JOIN OrderStatus s ON o.StatusID = s.StatusID WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (status != null && !status.isEmpty()) {
            sql.append(" AND o.StatusID = ?");
            params.add(Integer.parseInt(status));
        }
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (LOWER(u.FullName) LIKE ? OR LOWER(o.Id) LIKE ?)");
            params.add("%" + keyword.toLowerCase() + "%");
            params.add("%" + keyword.toLowerCase() + "%");
        }
        sql.append(" ORDER BY o.OrderDate DESC");
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("Id"));
                o.setCustomerName(rs.getString("FullName"));
                o.setOrderDate(rs.getTimestamp("OrderDate"));
                o.setSubtotal(rs.getDouble("Subtotal"));
                o.setTotal(rs.getDouble("Total"));
                Status s = new Status();
                s.setStatusID(rs.getInt("StatusID"));
                s.setStatusName(rs.getString("StatusName"));
                o.setStatus(s);
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}