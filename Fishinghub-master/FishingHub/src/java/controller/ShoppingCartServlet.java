package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ShoppingCartServlet")
public class ShoppingCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Lấy giỏ hàng từ session
        Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("CART");
        if (cart == null) {
            cart = new HashMap<>();
        }

        // Lấy hành động từ request
        String action = request.getParameter("action");

        if ("paySelected".equals(action)) {
            String[] selectedItems = request.getParameterValues("selectedItems");

            if (selectedItems != null && selectedItems.length > 0) {

                // Lấy hoặc khởi tạo danh sách đã thanh toán & thời gian giao hàng
                Map<String, Integer> orderedItems = (Map<String, Integer>) session.getAttribute("OrderedItems");
                if (orderedItems == null) {
                    orderedItems = new HashMap<>();
                }

                Map<String, Long> deliveryTimes = (Map<String, Long>) session.getAttribute("DeliveryTimes");
                if (deliveryTimes == null) {
                    deliveryTimes = new HashMap<>();
                }

                for (String itemId : selectedItems) {
                    if (cart.containsKey(itemId)) {
                        int quantity = cart.get(itemId);
                        orderedItems.put(itemId, quantity); // Thêm vào danh sách đã thanh toán
                        cart.remove(itemId); // Xóa khỏi giỏ hàng

                        long deliveryTime = System.currentTimeMillis() + (2 * 60 * 1000); // 2 phút sau
                        deliveryTimes.put(itemId, deliveryTime);
                    }
                }

                // Lưu lại vào session
                session.setAttribute("CART", cart);
                session.setAttribute("OrderedItems", orderedItems);
                session.setAttribute("DeliveryTimes", deliveryTimes);

                // Thông báo và chuyển hướng
                session.setAttribute("successMessage", "Mua hàng thành công!");
                response.sendRedirect("InProgress.jsp");
            } else {
                session.setAttribute("errorMessage", "Bạn chưa chọn sản phẩm nào để thanh toán.");
                response.sendRedirect("PendingOrder.jsp");
            }
        } else {
            // Hành động không hợp lệ
            response.sendRedirect("PendingOrder.jsp");
        }
    }
}
