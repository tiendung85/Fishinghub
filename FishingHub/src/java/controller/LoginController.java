package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    UserDao db = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Users user = db.getByEmailAndPassword(email, password);

        if (user != null) {
            // Lấy thời gian hiện tại
            long currentTime = System.currentTimeMillis();

            // Kiểm tra nếu người dùng đăng nhập trong vòng 48 giờ (2 ngày)
            if (user.getLastLoginTime() != null) {
                long timeDifference = currentTime - user.getLastLoginTime().getTime();
                if (timeDifference <= 48 * 60 * 60 * 1000L) {
                    user.setStatus("Active");
                } else {
                    user.setStatus("Inactive");
                }
            } else {
                user.setStatus("Inactive");
            }

            Timestamp currentTimestamp = new Timestamp(currentTime);
            user.setLastLoginTime(currentTimestamp);

            db.update(user);

            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if (user == null) {
                response.sendRedirect("login");
            } else {
                if (user.getRoleId() == 3) {
                    request.getRequestDispatcher("dashboard_admin/Dashboard.jsp").forward(request, response);
                } else {
                    response.sendRedirect("Home.jsp");
                }
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
