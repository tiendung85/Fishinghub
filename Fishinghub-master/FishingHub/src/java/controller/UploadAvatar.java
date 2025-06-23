package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;


@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class UploadAvatar extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect("Profile");
            return;
        }
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + "assets/img/user";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        String fullPath = uploadPath + File.separator + fileName;
        filePart.write(fullPath);

        String avatarWebPath = "assets/img/user/" + fileName;

        UserDao dao = new UserDao();
        dao.updateAvatar(user.getUserId(), avatarWebPath);

        // Cập nhật lại session user
        user.setAvatar(avatarWebPath);
        request.getSession().setAttribute("user", user);

        response.sendRedirect("Profile");
    }
}
