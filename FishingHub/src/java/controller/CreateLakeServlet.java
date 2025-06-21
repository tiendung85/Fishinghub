package controller;

import dal.FishingLakeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import java.io.IOException;

@WebServlet(name = "CreateLakeServlet", urlPatterns = {"/createLake"})
public class CreateLakeServlet extends HttpServlet {
    private final FishingLakeDAO fishingLakeDAO = new FishingLakeDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        String lakeName = request.getParameter("lakeName");
        String lakeLocation = request.getParameter("lakeLocation");
        int ownerId = currentUser.getUserId();

        try {
            fishingLakeDAO.createLake(lakeName, lakeLocation, ownerId);
            response.sendRedirect("profile");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Tạo hồ câu mới thất bại. Vui lòng thử lại!");
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
        }
    }
}