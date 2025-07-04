package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
<<<<<<< HEAD

@WebServlet(name = "LoginController", urlPatterns = { "/login" })
=======
import java.sql.Timestamp;

@WebServlet(name = "LoginController", urlPatterns = {"/login"})
>>>>>>> lam
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
=======
    // Lấy thời gian hiện tại
    long currentTime = System.currentTimeMillis();
    
    // Kiểm tra nếu người dùng đăng nhập trong vòng 48 giờ (2 ngày)
    if (user.getLastLoginTime() != null) {
        long timeDifference = currentTime - user.getLastLoginTime().getTime();
        if (timeDifference <= 48 * 60 * 60 * 1000L) { // 48 giờ
            user.setStatus("Active");
        } else {
            user.setStatus("Inactive");
        }
    } else {
        user.setStatus("Inactive"); // Nếu không có thông tin lần đăng nhập trước
    }

    // Cập nhật trạng thái và thời gian đăng nhập của người dùng
    Timestamp currentTimestamp = new Timestamp(currentTime);
    user.setLastLoginTime(currentTimestamp);
    
    // Không thay đổi trạng thái thành Active ở đây nếu không cần thiết
    // user.setStatus("Active"); // Loại bỏ dòng này nếu bạn không muốn cập nhật trạng thái mỗi lần đăng nhập

    db.update(user); // Cập nhật thông tin người dùng vào database

    HttpSession session = request.getSession();
    session.setAttribute("user", user);

    // Chuyển hướng đến trang chính
    response.sendRedirect("Home.jsp");
} else {
    // Nếu đăng nhập thất bại
    request.setAttribute("error", "Invalid email or password");
    request.getRequestDispatcher("/Login.jsp").forward(request, response);
}

>>>>>>> lam
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> lam
