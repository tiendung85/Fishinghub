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
import model.Events;
import model.Users;

public class AdminEventManagerController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        EventDAO dao = new EventDAO();
        ArrayList<Events> list = new ArrayList<>();
        
        // Pagination parameters
        int page = 1;
        int pageSize = 5;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1; // Prevent negative or zero pages
            }
        } catch (NumberFormatException e) {
            page = 1; // Fallback to page 1
            System.err.println("Invalid page parameter: " + e.getMessage());
        }

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        int totalEvents = 0;
        try {
            if (action.isEmpty()) {
                list = dao.getEventsList(page, pageSize);
                totalEvents = dao.getTotalEvents();
            } else if (action.equals("search")) {
                String search = request.getParameter("search");
                if (search != null && !search.trim().isEmpty()) {
                    list = dao.searchEvents(search, page, pageSize);
                    totalEvents = dao.getTotalSearchEvents(search);
                } else {
                    list = dao.getEventsList(page, pageSize);
                    totalEvents = dao.getTotalEvents();
                }
                request.setAttribute("search", search);
            } else if (action.equals("filter")) {
                String statusFilter = request.getParameter("status");
                if (statusFilter == null || statusFilter.isEmpty() || statusFilter.equals("all")) {
                    list = dao.getEventsList(page, pageSize);
                    totalEvents = dao.getTotalEvents();
                } else {
                    list = dao.filterEvents(statusFilter, page, pageSize);
                    totalEvents = dao.getTotalFilterEvents(statusFilter);
                }
                request.setAttribute("filter", statusFilter);
            } else if (action.equals("detail")) {
                int eventId = Integer.parseInt(request.getParameter("eventId"));
                Events event = dao.getDetailsEvents2(eventId);
                request.setAttribute("event", event);
                request.setAttribute("currentPage", page); // Preserve page for return
                request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                return;
            } else if (action.equals("approve")) {
                try {
                    int eventId = Integer.parseInt(request.getParameter("eventId"));
                    boolean approved = dao.approveEvent(eventId);
                    list = dao.getEventsList(page, pageSize);
                    totalEvents = dao.getTotalEvents();
                    updateEventStatus(list);
                    request.setAttribute("message", approved ? "Duyệt sự kiện thành công!" : "Không thể duyệt sự kiện.");
                } catch (Exception e) {
                    request.setAttribute("message", "Lỗi khi duyệt sự kiện: " + e.getMessage());
                }
            } else if (action.equals("reject")) {
                try {
                    int eventId = Integer.parseInt(request.getParameter("eventId"));
                    String rejectReason = request.getParameter("rejectReason");
                    if (rejectReason == null || rejectReason.trim().isEmpty()) {
                        request.setAttribute("message", "Vui lòng cung cấp lý do từ chối.");
                        request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                        return;
                    }
                    boolean rejected = dao.rejectEvent(eventId, rejectReason);
                    list = dao.getEventsList(page, pageSize);
                    totalEvents = dao.getTotalEvents();
                    updateEventStatus(list);
                    request.setAttribute("message", rejected ? "Từ chối sự kiện thành công!" : "Không thể từ chối sự kiện.");
                } catch (Exception e) {
                    request.setAttribute("message", "Lỗi khi từ chối sự kiện: " + e.getMessage());
                }
            }

            // Fallback for empty results
            if (list.isEmpty() && page > 1) {
                page = 1;
                list = dao.getEventsList(page, pageSize);
                totalEvents = dao.getTotalEvents();
                request.setAttribute("error", "Không có sự kiện ở trang được chọn, chuyển về trang 1.");
            }

            // Calculate total pages
            int totalPages = totalEvents == 0 ? 1 : (int) Math.ceil((double) totalEvents / pageSize);

            // Debugging output
            System.out.println("Action: " + action + ", Page: " + page + ", Total Events: " + totalEvents + ", List Size: " + list.size());

            // Set attributes
            updateEventStatus(list);
            request.setAttribute("listE", list);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalEvents", totalEvents);
            request.getRequestDispatcher("dashboard_admin/AdminEventManager.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Unexpected error in doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống khi tải danh sách sự kiện.");
            request.getRequestDispatcher("dashboard_admin/AdminEventManager.jsp").forward(request, response);
        }
    }

    private void updateEventStatus(ArrayList<Events> events) {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        for (Events e : events) {
            if (now.before(e.getStartTime())) {
                e.setEventStatus("Sắp diễn ra");
            } else if (now.after(e.getEndTime())) {
                e.setEventStatus("Đã kết thúc");
            } else {
                e.setEventStatus("Đang diễn ra");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles admin event management with robust pagination";
    }
}