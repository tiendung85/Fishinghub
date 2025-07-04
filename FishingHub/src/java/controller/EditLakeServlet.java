package controller;

import dal.FishingLakeDAO;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "EditLakeServlet", urlPatterns = {"/editLake"})
public class EditLakeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lakeIdStr = request.getParameter("lakeId");
        String name = request.getParameter("lakeName");
        String lakeLocation = request.getParameter("lakeLocation");
        if (lakeIdStr == null || name == null || lakeLocation == null) {
            response.sendRedirect("profile?error=missing_data");
            return;
        }
        int lakeId = Integer.parseInt(lakeIdStr);

        FishingLakeDAO lakeDAO = new FishingLakeDAO();
        try {
            lakeDAO.updateLake(lakeId, name, lakeLocation);
            response.sendRedirect("profile");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("profile");
        }
    }
}