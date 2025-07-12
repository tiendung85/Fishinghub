package controller;

import dal.EventDAO;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.EventParticipant;
import model.Users;

public class EventParticipantsController extends HttpServlet {
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
        String action = request.getParameter("action");
        EventDAO dao = new EventDAO();
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Pagination parameters
        int page = 1; // Default to page 1
        int pageSize = 5; // Number of participants per page
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1; // Fallback to page 1 if invalid
        }

        if (user == null) {
            response.sendRedirect("login");
        } else {
            ArrayList<EventParticipant> list = new ArrayList<>();
            int totalParticipants = 0;

            if (action == null || action.equals("list")) {
                // Fetch paginated participants
                list = dao.getParticipantsByEventId(eventId, page, pageSize);
                totalParticipants = dao.getTotalParticipantsByEventId(eventId);
            } else if (action.equals("search")) {
                String search = request.getParameter("keyword");
                if (search != null && !search.trim().isEmpty()) {
                    list = dao.searchParticipantsByEventId(eventId, search, page, pageSize);
                    totalParticipants = dao.getTotalSearchParticipants(eventId, search);
                } else {
                    list = dao.getParticipantsByEventId(eventId, page, pageSize);
                    totalParticipants = dao.getTotalParticipantsByEventId(eventId);
                }
                request.setAttribute("search", search);
            } else if (action.equals("filter")) {
                String status = request.getParameter("status");
                if (status == null || status.isEmpty()) {
                    list = dao.getParticipantsByEventId(eventId, page, pageSize);
                    totalParticipants = dao.getTotalParticipantsByEventId(eventId);
                } else {
                    boolean checkinStatus = status.equals("1");
                    list = dao.filterParticipantsByCheckin(eventId, checkinStatus, page, pageSize);
                    totalParticipants = dao.getTotalFilterParticipants(eventId, checkinStatus);
                }
                request.setAttribute("status", status);
            } else if (action.equals("checkin")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean updated = dao.updateCheckIn(eventId, userId);
                if (updated) {
                    request.setAttribute("success", "Check-in thành công!");
                } else {
                    request.setAttribute("error", "Check-in thất bại!");
                }
                list = dao.getParticipantsByEventId(eventId, page, pageSize);
                totalParticipants = dao.getTotalParticipantsByEventId(eventId);
            }

            // Calculate total pages
            int totalPages = (int) Math.ceil((double) totalParticipants / pageSize);

            // Set attributes for JSP
            request.setAttribute("listEP", list);
            request.setAttribute("eventId", eventId);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalParticipants", totalParticipants);
            request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles event participants management with pagination";
    }
}