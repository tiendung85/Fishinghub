package controller;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.ProductDAO;
import dal.UserPermissionDAO;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/ShoppingCartServlet")
public class ShoppingCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user != null) {
            int userId = user.getUserId();
            UserPermissionDAO permDao = new UserPermissionDAO();
            if (permDao.isDeniedPermission(userId, 7)) {
                session.setAttribute("errorMessage", "Bạn không thể mua hàng do vi phạm nội quy.");
                response.sendRedirect("ShopingCart.jsp");
                return;
            }
        }

        String action = request.getParameter("action");
        String[] selectedItems = request.getParameterValues("selectedItems");
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("CART");
        if (cart == null) cart = new HashMap<>();

        if ("paySelected".equals(action)) {
            if (selectedItems == null || selectedItems.length == 0) {
                session.setAttribute("errorMessage", "Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
                response.sendRedirect("ShopingCart.jsp");
                return;
            }

            String paymentMethod = request.getParameter("paymentMethod");
            if ("MOMO".equals(paymentMethod)) {
                response.sendRedirect("MomoNotSupported.jsp");
                return;
            }

            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

            double subtotal = 0;
            for (String id : selectedItems) {
                int productId = Integer.parseInt(id);
                int quantity = cart.get(id);
                double price = productDAO.getProductById(productId).getPrice();
                subtotal += price * quantity;
            }

            Order newOrder = new Order();
            newOrder.setUserId(user.getUserId());
            newOrder.setSubtotal(subtotal);
            newOrder.setTotal(subtotal);
            newOrder.setStatusId(1); // Đơn chờ xác nhận
            newOrder.setPaymentMethod(paymentMethod == null ? "COD" : paymentMethod);

            int orderId = orderDAO.createOrderReturnId(newOrder); // Đã có mã đơn

for (String id : selectedItems) {
    int productId = Integer.parseInt(id);
    int quantity = cart.get(id);
    double price = productDAO.getProductById(productId).getPrice();

    OrderDetail detail = new OrderDetail();
    detail.setOrderId(orderId);
    detail.setProductId(productId);
    detail.setCartQuantity(quantity);
    detail.setPrice(price);
    detail.setSubtotal(price * quantity);

    orderDetailDAO.createDetail(detail);  // PHẢI CÓ DÒNG NÀY!
    cart.remove(id);
}


            session.setAttribute("CART", cart);
            session.setAttribute("successMessage", "Đặt hàng thành công! Vui lòng chờ chủ hồ xác nhận đơn.");
            response.sendRedirect("ShopingCart.jsp");
            return;
        }

        // Các xử lý khác giữ nguyên
        if (action != null && action.startsWith("deleteItem_")) {
            String productId = action.substring("deleteItem_".length());
            cart.remove(productId);
            session.setAttribute("CART", cart);
            response.sendRedirect("ShopingCart.jsp");
            return;
        }

        if (action != null && action.startsWith("updateItem_")) {
            String productId = action.substring("updateItem_".length());
            String quantityParam = request.getParameter("quantity_" + productId);
            if (quantityParam != null) {
                try {
                    int quantity = Integer.parseInt(quantityParam);
                    if (quantity > 0) cart.put(productId, quantity);
                } catch (NumberFormatException e) {
                    // Ignore
                }
            }
            session.setAttribute("CART", cart);
            response.sendRedirect("ShopingCart.jsp");
            return;
        }

        if ("updateCart".equals(request.getParameter("btAction"))) {
            response.sendRedirect("ShopingCart.jsp");
            return;
        } else if ("deleteCart".equals(request.getParameter("btAction"))) {
            if (selectedItems != null) {
                for (String id : selectedItems) cart.remove(id);
            }
            session.setAttribute("CART", cart);
            response.sendRedirect("ShopingCart.jsp");
            return;
        }
        response.sendRedirect("ShopingCart.jsp");
    }
}
