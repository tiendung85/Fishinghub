<<<<<<< HEAD
package model;

=======
    package model;
>>>>>>> lam

import java.util.Date;

public class Order {

    private int id;
<<<<<<< HEAD
=======
    private int userId;         // THÊM DÒNG NÀY
>>>>>>> lam
    private String customerName;
    private Date orderDate;
    private double subtotal;
    private double total;
<<<<<<< HEAD
    private Status status;
=======
    private int statusId;       // THÊM DÒNG NÀY
    private Status status;
    private java.sql.Timestamp deliveryTime;
    // ... Getter và Setter
>>>>>>> lam

    public int getId() {
        return id;
    }
<<<<<<< HEAD

=======
>>>>>>> lam
    public void setId(int id) {
        this.id = id;
    }

<<<<<<< HEAD
    public String getCustomerName() {
        return customerName;
    }

=======
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCustomerName() {
        return customerName;
    }
>>>>>>> lam
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getOrderDate() {
        return orderDate;
    }
<<<<<<< HEAD

=======
>>>>>>> lam
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getSubtotal() {
        return subtotal;
    }
<<<<<<< HEAD

=======
>>>>>>> lam
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getTotal() {
        return total;
    }
<<<<<<< HEAD

=======
>>>>>>> lam
    public void setTotal(double total) {
        this.total = total;
    }

<<<<<<< HEAD
    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
=======
    public int getStatusId() {
        return statusId;
    }
    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
    public java.sql.Timestamp getDeliveryTime() {
    return deliveryTime;
}
public void setDeliveryTime(java.sql.Timestamp deliveryTime) {
    this.deliveryTime = deliveryTime;
}
}
>>>>>>> lam
