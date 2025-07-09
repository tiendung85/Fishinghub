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

@WebServlet(name = "DeleteLakeServlet", urlPatterns = { "/deleteLake" })
public class DeleteLakeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lakeIdStr = request.getParameter("lakeId");
        if (lakeIdStr == null) {
            response.sendRedirect("LakeServlet?error=missing_data");
            return;
        }
        int lakeId = Integer.parseInt(lakeIdStr);
        FishingLakeDAO lakeDAO = new FishingLakeDAO();
        try {
            lakeDAO.deleteLake(lakeId);
            response.sendRedirect("LakeServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("LakeServlet");
        }
    }
}