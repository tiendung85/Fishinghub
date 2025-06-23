package controller;

import dal.OrderDAO;
import model.Order;
import model.Status;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/Order"})
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        String keyword = request.getParameter("keyword");
        boolean isAjax = (status != null && (keyword != null));
        OrderDAO dao = new OrderDAO();
        List<Status> statuses = dao.getAllStatuses();
        if (isAjax) {
            // AJAX filter: trả về toàn bộ đơn hàng phù hợp, không phân trang
            List<Order> orders = dao.searchOrders(status, keyword);
            response.setContentType("text/html;charset=UTF-8");
            StringBuilder tbody = new StringBuilder();
            for (Order order : orders) {
                tbody.append("<tr class='hover:bg-gray-50 cursor-pointer' data-status='").append(order.getStatus().getStatusID()).append("' data-order-id='").append(order.getId()).append("' data-status-id='").append(order.getStatus().getStatusID()).append("'>");
                tbody.append("<td class='px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900'>#ORD-").append(order.getId()).append("</td>");
                tbody.append("<td class='px-6 py-4 whitespace-nowrap text-sm text-gray-500'>").append(order.getCustomerName()).append("</td>");
                tbody.append("<td class='px-6 py-4 whitespace-nowrap text-sm text-gray-500'>").append(new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(order.getOrderDate())).append("</td>");
                tbody.append("<td class='px-6 py-4 whitespace-nowrap text-sm text-gray-500'>").append(String.format("%,.0f", order.getSubtotal())).append(" ₫</td>");
                tbody.append("<td class='px-6 py-4 whitespace-nowrap text-sm text-gray-500'>").append(String.format("%,.0f", order.getTotal())).append(" ₫</td>");
                // Trạng thái
                String statusClass = "bg-gray-100 text-gray-800";
                int st = order.getStatus().getStatusID();
                if (st == 4) statusClass = "bg-purple-100 text-purple-800";
                else if (st == 2) statusClass = "bg-blue-100 text-blue-800";
                else if (st == 1) statusClass = "bg-yellow-100 text-yellow-800";
                else if (st == 3) statusClass = "bg-green-100 text-green-800";
                else if (st == 5) statusClass = "bg-red-100 text-red-800";
                tbody.append("<td class='px-6 py-4 whitespace-nowrap'><span class='inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium " + statusClass + "'>").append(order.getStatus().getStatusName()).append("</span></td>");
                // Thao tác
                tbody.append("<td class='px-6 py-4 whitespace-nowrap text-right text-sm font-medium'><div class='flex justify-end space-x-2'>");
                tbody.append("<button class='text-primary hover:text-indigo-900'>Xem</button>");
                if (st == 3 || st == 5) {
                    tbody.append("<button class='text-gray-400 cursor-not-allowed' disabled>Trạng thái</button>");
                } else {
                    tbody.append("<div class='dropdown relative'><button class='text-gray-600 hover:text-gray-900 dropdown-toggle'>Trạng thái</button><ul class='dropdown-menu absolute right-0 mt-2 min-w-[160px] bg-white shadow-lg rounded-md border border-gray-200 py-1 z-10' style='display:none;'>");
                    for (Status s : statuses) {
                        tbody.append("<li><a href=\"javascript:void(0)\" class='block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100' onclick=\"confirmStatusChange(" + s.getStatusID() + ", " + order.getId() + ", '" + s.getStatusName().replace("'", "\\'") + "')\">").append(s.getStatusName()).append("</a></li>");
                    }
                    tbody.append("</ul></div>");
                }
                tbody.append("</div></td></tr>");
            }
            // Trả về HTML tbody và tổng số đơn hàng, phân tách bằng ký tự đặc biệt
            response.getWriter().write(tbody.toString() + "<!--SPLIT--->" + orders.size());
            return;
        }
        // ...phân trang mặc định...
        int page = 1;
        int pageSize = 10;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        List<Order> orders = dao.getOrdersByPage(page, pageSize);
        int totalOrders = dao.getTotalOrderCount();
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
        int start = (totalOrders == 0) ? 0 : (page - 1) * pageSize + 1;
        int end = Math.min(page * pageSize, totalOrders);
        request.setAttribute("orders", orders);
        request.setAttribute("statuses", statuses);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("startOrder", start);
        request.setAttribute("endOrder", end);
        request.getRequestDispatcher("/dashboard_owner/Order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        String statusIdStr = request.getParameter("statusId");
        response.setContentType("application/json");
        try {
            int orderId = Integer.parseInt(orderIdStr);
            int statusId = Integer.parseInt(statusIdStr);
            OrderDAO dao = new OrderDAO();
            boolean ok = dao.updateOrderStatus(orderId, statusId);
            response.getWriter().write("{\"success\": " + ok + "}");
        } catch (Exception e) {
            response.getWriter().write("{\"success\": false}");
        }
    }
}