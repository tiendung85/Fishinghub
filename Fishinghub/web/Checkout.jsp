<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check Out</title>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/Product.jsp">Back</a>
        <div>
            <c:if test="${not empty order}">
                <div>
                    Hóa Đơn:
                    <div>
                        ID: ${order.id}
                    </div>
                    <div>
                        Khách Hàng: ${currentUser.fullName}
                    </div>
<!--                    <div>
                        Subtotal: ${order.subtotal}
                    </div>-->
                    <div>
                        Tổng Cộng: ${order.total}
                    </div>
                    <div>
                        Ngày Order: ${order.orderDate}
                    </div>  
                </div>
                <c:if test="${not empty detailList}">
                    <br/>
                    <br/>
                    <br/>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>ProductID</th>
                                <th>Số Lượng</th>
                                <th>Đơn Giá</th>
                                <th>Thành Tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${detailList}">
                                <tr>
                                    <td>${detail.id}</td>
                                    <td>${detail.productId}</td>
                                    <td>${detail.cartQuantity}</td>
                                    <td>${detail.price}</td>
                                    <td>${detail.subtotal}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </c:if>
            </c:if>
        </div>

    </body>
</html>