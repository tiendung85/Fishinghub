/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class OrderDetail {

    private int Id;
    private int OrderId;
    private int ProductId;
    private int CartQuantity;
    private double Price;
    private double Subtotal;

    public OrderDetail() {
    }

    public OrderDetail(int Id, int OrderId, int ProductId, int CartQuantity, double Price, double Subtotal) {
        this.Id = Id;
        this.OrderId = OrderId;
        this.ProductId = ProductId;
        this.CartQuantity = CartQuantity;
        this.Price = Price;
        this.Subtotal = Subtotal;
    }

    public int getId() {
        return Id;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public int getOrderId() {
        return OrderId;
    }

    public void setOrderId(int OrderId) {
        this.OrderId = OrderId;
    }

    public int getProductId() {
        return ProductId;
    }

    public void setProductId(int ProductId) {
        this.ProductId = ProductId;
    }

    public int getCartQuantity() {
        return CartQuantity;
    }

    public void setCartQuantity(int CartQuantity) {
        this.CartQuantity = CartQuantity;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }

    public double getSubtotal() {
        return Subtotal;
    }

    public void setSubtotal(double Subtotal) {
        this.Subtotal = Subtotal;
    }

}
