package model;

import java.util.Date;

public class Order {

    private int id;
    private int userId;                 // Người đặt hàng
    private String customerName;        // Tên người đặt (nếu cần)
    private Date orderDate;             // Thời gian đặt hàng (có thể là java.sql.Timestamp)
    private double subtotal;            // Tổng phụ
    private double total;               // Tổng tiền
    private int statusId;               // Trạng thái đơn hàng (đang xử lý, đã giao,...)
    private Status status;              // Đối tượng trạng thái (nếu có)
    private java.sql.Timestamp deliveryTime; // Thời gian giao (nếu có)
    private String paymentMethod;
    private String rejectReason;
    private boolean isReviewed;


    // GETTER và SETTER
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public int getStatusId() { return statusId; }
    public void setStatusId(int statusId) { this.statusId = statusId; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public java.sql.Timestamp getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(java.sql.Timestamp deliveryTime) { this.deliveryTime = deliveryTime; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public boolean isReviewed() {
    return isReviewed;
}

public void setReviewed(boolean reviewed) {
    isReviewed = reviewed;
}

}
