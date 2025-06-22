package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
    UserDao db = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Users user = db.getByEmailAndPassword(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Check roleId and redirect accordingly
            if (user.getRoleId() == 3) {
                response.sendRedirect("dashboard_admin/Dashboard.jsp");
            } else {
                response.sendRedirect("Home.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }
}