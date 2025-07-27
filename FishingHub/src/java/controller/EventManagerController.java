package controller;

import dal.EventDAO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import model.EventNotification;
import model.EventRejections;
import model.Events;
import model.Users;

public class EventManagerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        String search = request.getParameter("search");
        String statusFilter = request.getParameter("status");

        // Xử lý phân trang
        int page = 1;
        int pageSize = 5; // Số sự kiện mỗi trang
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
            } catch (NumberFormatException e) {
                pageSize = 5;
            }
        }
        if (user == null) {
            response.sendRedirect("login");
        } else {
            EventDAO dao = new EventDAO();
            ArrayList<Events> list = new ArrayList<>();
            int totalItems = 0;
            ArrayList<EventNotification> notifications = dao.getNotificationsByUserId(user.getUserId());
            request.setAttribute("notifications", notifications);

            Timestamp now = new Timestamp(System.currentTimeMillis());

            if (action.isEmpty()) {
                list = dao.getEvents(user.getUserId(), page, pageSize);
                totalItems = dao.getTotalEvents(user.getUserId());
            } else if (action.equals("search")) {
                list = search != null && !search.trim().isEmpty()
                        ? dao.searchEvents(user.getUserId(), search, page, pageSize)
                        : dao.getEvents(user.getUserId(), page, pageSize);
                totalItems = search != null && !search.trim().isEmpty()
                        ? dao.getTotalSearchEvents(user.getUserId(), search)
                        : dao.getTotalEvents(user.getUserId());
                request.setAttribute("search", search);
            } else if (action.equals("filter")) {
                list = statusFilter != null ? dao.filterEvents(user.getUserId(), statusFilter, page, pageSize)
                        : dao.getEvents(user.getUserId(), page, pageSize);
                totalItems = statusFilter != null ? dao.getTotalFilterEvents(user.getUserId(), statusFilter)
                        : dao.getTotalEvents(user.getUserId());
                request.setAttribute("filter", statusFilter);
            } else if (action.equals("delete")) {
                try {
                    int id = Integer.parseInt(request.getParameter("eventId"));
                    boolean deleted = dao.deleteEvent(id);
                    request.setAttribute("message", deleted ? "Xóa sự kiện thành công!"
                            : "Không thể xóa sự kiện đã được duyệt hoặc không tồn tại.");
                    list = dao.getEvents(user.getUserId(), page, pageSize);
                    totalItems = dao.getTotalEvents(user.getUserId());
                } catch (Exception e) {
                    request.setAttribute("message", "Lỗi khi xóa sự kiện.");
                }
            } else if ("getRejection".equals(action)) {
                try {
                    int eventId = Integer.parseInt(request.getParameter("eventId"));
                    EventRejections rejection = dao.getRejectionByEventId(eventId);
                    if (rejection != null) {
                        request.setAttribute("rejectionReason", rejection.getRejectReason());
                        request.setAttribute("rejectionTime",
                                rejection.getRejectedAt() != null ? rejection.getRejectedAt().toString() : "");
                    } else {
                        request.setAttribute("rejectionReason", "Không tìm thấy lý do từ chối cho sự kiện này.");
                        request.setAttribute("rejectionTime", "");
                    }
                    request.setAttribute("showModal", true);
                    // Reload event list to maintain context
                    list = dao.getEvents(user.getUserId(), page, pageSize);
                    totalItems = dao.getTotalEvents(user.getUserId());
                } catch (NumberFormatException e) {
                    request.setAttribute("rejectionReason", "ID sự kiện không hợp lệ.");
                    request.setAttribute("rejectionTime", "");
                    request.setAttribute("showModal", true);
                    list = dao.getEvents(user.getUserId(), page, pageSize);
                    totalItems = dao.getTotalEvents(user.getUserId());
                } catch (Exception e) {
                    request.setAttribute("rejectionReason", "Lỗi khi lấy thông tin từ chối.");
                    request.setAttribute("rejectionTime", "");
                    request.setAttribute("showModal", true);
                    list = dao.getEvents(user.getUserId(), page, pageSize);
                    totalItems = dao.getTotalEvents(user.getUserId());
                }
            }

            int totalPages = (int) Math.ceil((double) totalItems / pageSize);

            for (Events e : list) {
                if (now.before(e.getStartTime())) {
                    e.setEventStatus("Sắp diễn ra");
                } else if (now.after(e.getEndTime())) {
                    e.setEventStatus("Đã kết thúc");
                } else {
                    e.setEventStatus("Đang diễn ra");
                }
            }

            request.setAttribute("listE", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalItems", totalItems);
            request.setAttribute("action", action);
            request.getRequestDispatcher("dashboard_owner/EventManager.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý POST giống GET
    }

    @Override
    public String getServletInfo() {
        return "Event Manager Controller with Pagination";
    }
}