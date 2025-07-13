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

public class EventListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String action = request.getParameter("action") != null ? request.getParameter("action") : "";
        
        int page = 1;
        int pageSize = 9;
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
                pageSize = 9;
            }
        }

        System.out.println("Action: " + action + ", Page: " + page + ", PageSize: " + pageSize);

        EventDAO dao = new EventDAO();
        ArrayList<Events> list;
        int totalItems = 0;

        if (action.isEmpty()) {
            list = dao.getEvents(page, pageSize);
            totalItems = dao.getTotalEvents();
        } else if (action.equals("upcoming")) {
            list = dao.upComingEvents(page, pageSize);
            totalItems = dao.getTotalUpcomingEvents();
        } else if (action.equals("ongoing")) {
            list = dao.getOngoingEvents(page, pageSize);
            totalItems = dao.getTotalOngoingEvents();
        } else if (action.equals("saved")) {
            list = user != null ? dao.getSavedEvents(user.getUserId(), page, pageSize) : new ArrayList<>();
            totalItems = user != null ? dao.getTotalSavedEvents(user.getUserId()) : 0;
        } else {
            list = new ArrayList<>();
            totalItems = 0;
        }

        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        System.out.println("Total Items: " + totalItems + ", Total Pages: " + totalPages + ", List Size: " + list.size());

        Timestamp now = new Timestamp(System.currentTimeMillis());
        ArrayList<Boolean> isRegisteredList = new ArrayList<>();

        for (Events e : list) {
            if (now.before(e.getStartTime())) {
                e.setEventStatus("Sắp diễn ra");
            } else if (now.after(e.getEndTime())) {
                e.setEventStatus("Đã kết thúc");
            } else {
                e.setEventStatus("Đang diễn ra");
            }

            boolean isRegistered = false;
            if (user != null) {
                isRegistered = dao.isUserRegistered(e.getEventId(), user.getUserId());
            }
            isRegisteredList.add(isRegistered);
        }

        request.setAttribute("listE", list);
        request.setAttribute("isRegisteredList", isRegisteredList);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("action", action);
        request.getRequestDispatcher("Event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Có thể xử lý POST nếu cần
    }

    @Override
    public String getServletInfo() {
        return "Event List Controller with Pagination";
    }
}
