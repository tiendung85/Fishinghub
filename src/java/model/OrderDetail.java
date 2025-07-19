package model;

public class OrderDetail {

    private int id;             // Mã chi tiết đơn hàng
    private int orderId;        // Mã đơn hàng
    private int productId;      // Mã sản phẩm
    private int cartQuantity;   // Số lượng sản phẩm
    private double price;       // Đơn giá từng sản phẩm
    private double subtotal;    // Thành tiền của dòng này

    // Constructor
    public OrderDetail() { }

    public OrderDetail(int id, int orderId, int productId, int cartQuantity, double price, double subtotal) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.cartQuantity = cartQuantity;
        this.price = price;
        this.subtotal = subtotal;
    }

    // GETTER & SETTER
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getCartQuantity() { return cartQuantity; }
    public void setCartQuantity(int cartQuantity) { this.cartQuantity = cartQuantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }
}
