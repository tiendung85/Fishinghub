package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

public class ViewUserController extends HttpServlet {

    private UserDao userDB = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy ID người dùng từ URL
        int userId = Integer.parseInt(request.getParameter("id"));
        
        // Lấy thông tin người dùng từ database
        Users user = userDB.getUserById(userId);
        
        if (user == null) {
            request.setAttribute("error", "Người dùng không tồn tại.");
            request.getRequestDispatcher("/UserManager.jsp").forward(request, response);
            return;
        }

        // Chuyển thông tin người dùng tới trang ViewUser.jsp
        request.setAttribute("user", user);
        request.getRequestDispatcher("/ViewUser.jsp").forward(request, response);
    }
}
