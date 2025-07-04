package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "EditProfileController", urlPatterns = {"/EditProfileController"})
public class EditProfileController extends HttpServlet {

    private UserDao userDB = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Lấy dữ liệu mới từ form
        String fullName = request.getParameter("fullName");
        String location = request.getParameter("location");

        // Update lại thông tin cho user
        user.setFullName(fullName);
        user.setLocation(location);

        // Update vào database
        userDB.update(user);

        // Cập nhật lại session
        request.getSession().setAttribute("user", user);

        // Trả về lại profile với thông báo
        request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        request.getRequestDispatcher("/Profile.jsp").forward(request, response);
    }
}
