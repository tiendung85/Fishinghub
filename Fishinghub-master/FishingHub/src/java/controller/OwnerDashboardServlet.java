package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "OwnerDashboardServlet", urlPatterns = {"/OwnerDashboard"})
public class OwnerDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ tạo urlPattern, chưa xử lý logic

//        request.setAttribute("orders", orders);
        request.getRequestDispatcher("dashboard_owner/Dashboard.jsp").forward(request, response);
    }
}