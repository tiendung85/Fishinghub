/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Product {
    private int ProductId;
    private String Name;
    private double Price;
    private String Image;
    private int StockQuantity;
    private int SoldQuantity;
    private int CategoryId;

    public Product() {
    }

    public Product(int ProductId, String Name, double Price, String Image, int StockQuantity, int SoldQuantity, int CategoryId) {
        this.ProductId = ProductId;
        this.Name = Name;
        this.Price = Price;
        this.Image = Image;
        this.StockQuantity = StockQuantity;
        this.SoldQuantity = SoldQuantity;
        this.CategoryId = CategoryId;
    }

    public int getProductId() {
        return ProductId;
    }

    public void setProductId(int ProductId) {
        this.ProductId = ProductId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getStockQuantity() {
        return StockQuantity;
    }

    public void setStockQuantity(int StockQuantity) {
        this.StockQuantity = StockQuantity;
    }

    public int getSoldQuantity() {
        return SoldQuantity;
    }

    public void setSoldQuantity(int SoldQuantity) {
        this.SoldQuantity = SoldQuantity;
    }

    public int getCategoryId() {
        return CategoryId;
    }

    public void setCategoryId(int CategoryId) {
        this.CategoryId = CategoryId;
    }
}