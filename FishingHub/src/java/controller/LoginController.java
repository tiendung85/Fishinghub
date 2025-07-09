package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
<<<<<<< HEAD
import java.sql.Timestamp;

@WebServlet(name = "LoginController", urlPatterns = { "/login" })
=======

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
>>>>>>> origin/NgocDung
public class LoginController extends HttpServlet {
    UserDao db = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Users user = db.getByEmailAndPassword(email, password);

        if (user != null) {
<<<<<<< HEAD
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

            if (user.getRoleId() == 3) {
                response.sendRedirect("dashboard_admin/Dashboard.jsp");
            } else {
                response.sendRedirect("Home.jsp");
            }
        } else {

            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }

=======
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("Home.jsp");  // Chuyển đến trang chính
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
>>>>>>> origin/NgocDung
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
<<<<<<< HEAD
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
=======
        request.getRequestDispatcher("Login.jsp").forward(request, response);
>>>>>>> origin/NgocDung
    }
}