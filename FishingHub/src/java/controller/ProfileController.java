package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "ProfileController", urlPatterns = { "/Profile" })
@MultipartConfig
public class ProfileController extends HttpServlet {
    private UserDao userDB = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        Part avatarPart = request.getPart("avatar");
        String avatarPath = user.getAvatar(); // Giữ avatar cũ nếu không có ảnh mới

        if (avatarPart != null && avatarPart.getSize() > 0) {
            // Tạo tên file duy nhất cho avatar
            String fileName = UUID.randomUUID().toString() + ".png";
            String uploadDir = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "img"
                    + File.separator;
            File uploadFile = new File(uploadDir, fileName);
            avatarPart.write(uploadFile.getAbsolutePath());

            avatarPath = "assets/img/" + fileName;
        }

        // Cập nhật avatar trong cơ sở dữ liệu
        user.setAvatar(avatarPath);
        userDB.update(user);

        // Lưu lại trong session
        request.getSession().setAttribute("user", user);

        // Chuyển hướng lại trang profile
        response.sendRedirect("Profile");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/Profile.jsp").forward(request, response);
    }
}