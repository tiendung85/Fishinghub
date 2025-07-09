package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

<<<<<<< HEAD
@WebServlet(name = "LogoutController", urlPatterns = { "/logout" })
=======
@WebServlet(name = "LogoutController", urlPatterns = {"/logout"})
>>>>>>> origin/NgocDung
public class LogoutController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
<<<<<<< HEAD
        response.sendRedirect("Home.jsp");
=======
        response.sendRedirect("Login.jsp");
>>>>>>> origin/NgocDung
    }
}