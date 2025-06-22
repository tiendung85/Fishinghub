<%-- 
    Document   : ShopingCart
    Created on : 22 thg 6, 2025, 17:57:34
    Author     : MINH DUNG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Product" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.Category" %>
<%@ page import="model.Users" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
                        Map<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("CART");
                        int totalQuantity = 0;
                        if (cart == null || cart.isEmpty()) {
                            // Cart is empty or not initialized
                            
                            cart = new HashMap<>();
                        } else {
                            for (int quantity : cart.values()) {
                                totalQuantity += quantity;
                            }
                        }
        %>
        <div class="lg:w-1/4" id="hello" style="display: block">
            <h3 class="font-bold text-gray-800 mb-3">CART</h3>

            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Số Lượng</th>
                        <th>Đơn Giá</th>
                        <th>Thành Tiền</th>
                        <th>Cập Nhập</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        ProductDAO productDAO = new ProductDAO();
                        if(!cart.isEmpty()){
                            for (String id : cart.keySet()){
                                Product product = productDAO.getProductById(Integer.parseInt(id));
                    %>
                <form action="ProductServlet" method="POST">
                    <tr>
                        <td>
                            <input type="hidden" name="productId" value="<%=id%>" />
                            <%=id%>
                        </td>
                        <td>
                            <%=product.getName()%>
                        </td>
                        <td>
                            <input type="text" name="quantity" value="<%=cart.get(id)%>" />
                        </td>
                        <td>
                            <%=product.getPrice()%>
                        </td>
                        <td>
                            <%=cart.get(id) * product.getPrice()%>                                    
                        </td>
                        <td>
                            <button type="submit" value="updateCart" name="btAction">Update</button>
                            <button type="submit" value="deleteCart" name="btAction">Delete</button>
                        </td>
                    </tr>
                </form>
                <%
                                        }
                                    }
                %>
                </tbody>
            </table>
            <br/>
            <br/>
            <form action="Order" method="POST">
                <button type="submit" value="createOrder" name="action">Order</button>
            </form>

        </div>
        <div>
            <a href="Product.jsp">Back</a>
        </div>
    </body>
</html>
