package controller;

import dal.UserDao;
import model.Users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagerController", urlPatterns = { "/UserManager" })
public class UserManagerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Users currentUser = (Users) request.getSession().getAttribute("user");
        if (currentUser == null || currentUser.getRoleId() != 3) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String searchQuery = request.getParameter("searchQuery");
        String roleFilter = request.getParameter("role");

        UserDao userDao = new UserDao();
        List<Users> userList = userDao.listFiltered(searchQuery, roleFilter);
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("UserManager.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            UserDao userDao = new UserDao();
            userDao.delete(userId);
        }

        response.sendRedirect("UserManager");
    }
}