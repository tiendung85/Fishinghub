<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="model.Users"%>
        <%
    Users user = (Users) session.getAttribute("user");
        int productId = Integer.parseInt(request.getParameter("productId"));


%>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Đánh giá sản phẩm</title>
            </head>

            <body>
                <h2>Đánh giá sản phẩm</h2>
                <form action="RatingServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="productId" value="<%= productId %>">

                    <label>Đánh giá (1-5 sao):</label>
                    <input type="number" name="rating" min="1" max="5" required> <br>

                    <label>Nội dung đánh giá (tối đa 500 ký tự):</label><br>
                    <textarea name="reviewText" maxlength="500" required style="width:300px;height:80px"></textarea><br>

                    <label>Chọn ảnh (jpg/png, ≤ 2MB):</label>
                    <input type="file" name="image" accept="image/*"><br>

                    <label>Chọn video (mp4, ≤ 10MB):</label>
                    <input type="file" name="video" accept="video/mp4,video/*"><br>

                    <button type="submit">Gửi đánh giá</button>
                </form>
                <%
        String message = (String) session.getAttribute("message");
        if (message != null) {
            out.println("<div style='color:red;'>" + message + "</div>");
            session.removeAttribute("message");
        }
    %>
            </body>

            </html>