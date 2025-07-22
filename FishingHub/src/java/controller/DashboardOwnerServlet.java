package controller;


import dal.OrderDAO;
import dal.EventDAO;
import model.Users;
import model.Events;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardOwnerServlet", urlPatterns = {"/OwnerDashboard"})
public class DashboardOwnerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null
                || !Integer.valueOf(2).equals(session.getAttribute("roleId"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        EventDAO eventDAO = new EventDAO();

        

        // lấy danh sách sự kiện đang diễn ra
        List<Events> ongoingEvents = eventDAO.getOngoingEvents();
        System.out.println("Sự kiện đang diễn ra: " + ongoingEvents.size());

        
        request.setAttribute("ongoingEvents", ongoingEvents);

        request.getRequestDispatcher("dashboard_owner/Dashboard.jsp").forward(request, response);
    }
}
