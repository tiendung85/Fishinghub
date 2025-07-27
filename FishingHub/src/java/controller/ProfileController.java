package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.IOException;


@WebServlet(name = "ProfileController", urlPatterns = {"/Profile"})
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

        request.getSession().setAttribute("user", user);

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
