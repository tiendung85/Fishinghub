package controller;

import dal.ProductDAO;
import dal.UserPermissionDAO;
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
        if (cart == null) {
            cart = new HashMap<>();
        }

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
                    if (quantity > 0) {
                        cart.put(productId, quantity);
                    }
                } catch (NumberFormatException e) {
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
                for (String id : selectedItems) {
                    cart.remove(id);
                }
            }
            session.setAttribute("CART", cart);
response.sendRedirect("ShopingCart.jsp");
            return;

        } else if ("paySelected".equals(action)) {
            if (selectedItems == null || selectedItems.length == 0) {
                session.setAttribute("errorMessage", "Vui lòng chọn ít nhất một sản phẩm để thanh toán.");
                response.sendRedirect("ShopingCart.jsp");
                return;
            }

            Map<String, Integer> orderedItems = (Map<String, Integer>) session.getAttribute("OrderedItems");
            if (orderedItems == null) {
                orderedItems = new HashMap<>();
            }

            Map<String, Long> deliveryTimes = (Map<String, Long>) session.getAttribute("DeliveryTimes");
            if (deliveryTimes == null) {
                deliveryTimes = new HashMap<>();
            }

            long currentTime = System.currentTimeMillis();
            long deliveryDelay = 2 * 60 * 1000; // 2 phút

            for (String id : selectedItems) {
                if (cart.containsKey(id)) {
                    int quantity = cart.get(id);
                    orderedItems.put(id, quantity);
                    deliveryTimes.put(id, currentTime + deliveryDelay);
                    cart.remove(id);
                }
            }

            session.setAttribute("OrderedItems", orderedItems);
            session.setAttribute("DeliveryTimes", deliveryTimes);
            session.setAttribute("CART", cart);

            response.sendRedirect("InProgress.jsp");
            return;
        }

        // Mặc định quay lại giỏ hàng
        response.sendRedirect("ShopingCart.jsp");
    }
}