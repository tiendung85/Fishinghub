<%@ page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ page import="model.Product" %>
        <%@ page import="dal.ProductDAO" %>
            <%@ page import="java.util.Map" %>
                <%@ page import="java.util.HashMap" %>
                    <%@ page import="model.Users" %>

                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta charset="UTF-8">
                            <title>Giỏ Hàng</title>
                            <!-- Bootstrap CSS -->
                            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
                            <!-- Animate.css -->
                            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
                            <!-- Google Fonts -->
                            <link rel="preconnect" href="https://fonts.googleapis.com">
                            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
                            <!-- Custom CSS -->
                            <style>
                                body {
                                    font-family: 'Roboto', sans-serif;
                                    background-color: #f8f9fa;
                                    padding: 20px;
                                }
                                
                                .container {
                                    max-width: 1200px;
                                    margin: 0 auto;
                                }
                                
                                h3 {
                                    color: #343a40;
                                    font-weight: 700;
                                    margin-bottom: 20px;
                                    text-align: center;
                                }
                                
                                .tabs {
                                    margin-bottom: 20px;
                                    text-align: center;
                                }
                                
                                .tabs button {
                                    background-color: #007bff;
                                    color: white;
                                    border: none;
                                    padding: 10px 20px;
                                    margin: 0 5px;
                                    border-radius: 5px;
                                    transition: background-color 0.3s ease;
                                }
                                
                                .tabs button:hover {
                                    background-color: #0056b3;
                                }
                                
                                .table {
                                    background-color: white;
                                    border-radius: 8px;
                                    overflow: hidden;
                                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                }
                                
                                .table th,
                                .table td {
                                    vertical-align: middle;
                                    text-align: center;
                                }
                                
                                .table th {
                                    background-color: #007bff;
                                    color: white;
                                }
                                
                                .table input[type="number"] {
                                    width: 80px;
                                    text-align: center;
                                }
                                
                                .btn-action {
                                    margin: 5px;
                                    transition: transform 0.2s;
                                }
                                
                                .btn-action:hover {
                                    transform: scale(1.05);
                                }
                                
                                #total {
                                    font-size: 1.2rem;
                                    color: #dc3545;
                                    text-align: right;
                                    margin-top: 20px;
                                }
                                
                                .error-message {
                                    background-color: #f8d7da;
                                    color: #721c24;
                                    padding: 10px;
                                    border-radius: 5px;
                                    margin-bottom: 20px;
                                    text-align: center;
                                }
                                
                                .back-link {
                                    display: inline-block;
                                    margin-top: 20px;
                                    color: #007bff;
                                    text-decoration: none;
                                    font-weight: 500;
                                }
                                
                                .back-link:hover {
                                    color: #0056b3;
                                    text-decoration: underline;
                                }
                            </style>
                        </head>

                        <body>
                            <div class="container">
                                <%
            Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("CART");
            if (cart == null) {
                cart = new HashMap<>();
            }

            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
                                    <div class="error-message animate__animated animate__fadeIn">
                                        <%= errorMessage %>
                                    </div>
                                    <%
                session.removeAttribute("errorMessage");
            }
        %>
        <%
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
%>
    <div class="alert alert-success animate__animated animate__fadeIn">
        <%= successMessage %>
    </div>
<%
        session.removeAttribute("successMessage");
    }
%>

                                        <div class="tabs">
    <button class="animate__animated animate__bounceIn" onclick="window.location.href='MyWaitingOrders'">Chờ xác nhận</button>
    <button class="animate__animated animate__bounceIn" onclick="window.location.href='InProgress'">Đang giao</button>
    <button class="animate__animated animate__bounceIn" onclick="window.location.href='Delivered'">Đã nhận</button>
</div>
                                        <h3 class="animate__animated animate__fadeInDown">Giỏ Hàng</h3>
                                        <% 
            if (cart.isEmpty()) {
        %>
                                            <p class="text-center">Giỏ hàng của bạn hiện tại chưa có sản phẩm.</p>
                                            <% 
            } else {
        %>
                                                <form action="ShoppingCartServlet" method="POST">
                                                    <table class="table table-striped animate__animated animate__fadeIn">
                                                        <thead>
                                                            <tr>
                                                                <th>Chọn</th>
                                                                <th>ID</th>
                                                                <th>Tên Sản Phẩm</th>
                                                                <th>Số Lượng</th>
                                                                <th>Đơn Giá</th>
                                                                <th>Thành Tiền</th>
                                                                <th>Thao Tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                        ProductDAO productDAO = new ProductDAO();
                        for (String id : cart.keySet()) {
                            Product product = productDAO.getProductById(Integer.parseInt(id));
                            double productTotal = cart.get(id) * product.getPrice();
                    %>
                                                                <tr>
                                                                    <td><input type="checkbox" name="selectedItems" value="<%= id %>"></td>
                                                                    <td>
                                                                        <%= id %>
                                                                    </td>
                                                                    <td>
                                                                        <%= product.getName() %>
                                                                    </td>
                                                                    <td><input type="number" name="quantity_<%= id %>" value="<%= cart.get(id) %>" min="1" class="form-control" /></td>
                                                                    <td>
                                                                        <%= product.getPrice() %>
                                                                    </td>
                                                                    <td class="product-total">
                                                                        <%= productTotal %>
                                                                    </td>
                                                                    <td>
                                                                        <button type="submit" name="action" value="updateItem_<%= id %>" class="btn btn-primary btn-sm btn-action animate__animated animate__pulse">Cập nhật</button>
                                                                        <button type="submit" name="action" value="deleteItem_<%= id %>" class="btn btn-danger btn-sm btn-action animate__animated animate__pulse">Xóa</button>
                                                                    </td>
                                                                </tr>
                                                                <%
                        }
                    %>
                                                        </tbody>
                                                    </table>
                                                    <p id="total"><strong>Tổng cộng:</strong> 0 đ</p>
                                                     <div class="mb-3">
        <label><strong>Chọn phương thức thanh toán:</strong></label><br>
        <input type="radio" name="paymentMethod" value="COD" checked> Thanh toán khi nhận hàng (COD)<br>
        <input type="radio" name="paymentMethod" value="MOMO"> Thanh toán qua Momo (chưa hỗ trợ)<br>
    </div>
                                                    <button type="submit" name="action" value="paySelected" class="btn btn-success btn-action animate__animated animate__bounceIn">Thanh Toán</button>
                                                </form>
                                                <% } %>

                                                    <div>
                                                        <a href="Product.jsp" class="back-link">← Quay lại trang sản phẩm</a>
                                                    </div>
                            </div>


                            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>


                            <script>
                                function updateTotalAndLine() {
                                    let checkboxes = document.querySelectorAll("input[name='selectedItems']");
                                    let total = 0;

                                    checkboxes.forEach(function(checkbox) {
                                        let row = checkbox.closest("tr");
                                        let quantityInput = row.querySelector("input[type='number']");
                                        let unitPrice = parseFloat(row.cells[4].innerText);
                                        let quantity = parseInt(quantityInput.value);

                                        let lineTotal = unitPrice * quantity;
                                        row.querySelector(".product-total").innerText = lineTotal.toLocaleString();

                                        if (checkbox.checked) {
                                            total += lineTotal;
                                        }
                                    });

                                    document.getElementById("total").innerHTML = "<strong>Tổng cộng:</strong> " + total.toLocaleString() + " đ";
                                }

                                document.addEventListener("DOMContentLoaded", function() {
                                    document.querySelectorAll("input[name='selectedItems'], input[type='number']").forEach(function(elem) {
                                        elem.addEventListener("change", updateTotalAndLine);
                                    });

                                    updateTotalAndLine();
                                });
                            </script>
                        </body>

                        </html>