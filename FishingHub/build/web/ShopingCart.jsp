<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.Users" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ Hàng</title>
    </head>
    <body>
        <%
            Map<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("CART");
            if (cart == null || cart.isEmpty()) {
                cart = new HashMap<>();
            }
        %>

        <div class="lg:w-1/4" id="hello" style="display: block">
            <h3 class="font-bold text-gray-800 mb-3">Giỏ Hàng</h3>

            <form action="ShoppingCartServlet" method="POST">
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Số Lượng</th>
                            <th>Đơn Giá</th>
                            <th>Thành Tiền</th>
                            <th>Chọn</th>
                            <th>Cập Nhật</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ProductDAO productDAO = new ProductDAO();
                            double totalAmount = 0;
                            for (String id : cart.keySet()) {
                                Product product = productDAO.getProductById(Integer.parseInt(id));
                                double productTotal = cart.get(id) * product.getPrice();
                                totalAmount += productTotal;
                        %>
                        <tr>
                            <td>
                                <input type="hidden" name="productId" value="<%= id %>" />
                                <%= id %>
                            </td>
                            <td>
                                <%= product.getName() %>
                            </td>
                            <td>
                                <input type="text" name="quantity" value="<%= cart.get(id) %>" />
                            </td>
                            <td>
                                <%= product.getPrice() %>
                            </td>
                            <td>
                                <%= productTotal %>
                            </td>
                            <td>
                                <!-- Thêm checkbox để người dùng có thể chọn sản phẩm -->
                                <input type="checkbox" name="selectedItems" value="<%= id %>" />
                            </td>
                            <td>
                                <button type="submit" value="updateCart" name="btAction">Cập Nhật</button>
                                <button type="submit" value="deleteCart" name="btAction">Xóa</button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <br/>
                
                <button type="submit" name="action" value="createOrder">Thanh Toán</button>
            </form>

            <div>
                <a href="Product.jsp">Quay lại</a>
            </div>
        </div>
    </body>
</html>
