package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import google.GoogleUtils;
import google.GoogleUser;
import dal.UserDao;
import model.Users;

import java.io.IOException;

@WebServlet("/google-login")
public class GoogleLoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            // Nếu chưa có code, redirect đến link login Google
            String authUrl = "https://accounts.google.com/o/oauth2/auth?"
                    + "scope=email%20profile"
                    + "&redirect_uri=" + GoogleUtils.GOOGLE_REDIRECT_URI
                    + "&response_type=code"
                    + "&client_id=" + GoogleUtils.GOOGLE_CLIENT_ID
                    + "&approval_prompt=force";
            response.sendRedirect(authUrl);
            return;
        }

        // Đã có code, xử lý đăng nhập
        String accessToken = GoogleUtils.getToken(code);
        GoogleUser googleUser = GoogleUtils.getUserInfo(accessToken);

        // Tìm user trong DB, nếu chưa có thì tạo mới (dùng UserDao của bạn)
        UserDao userDao = new UserDao();
        Users user = userDao.getByEmail(googleUser.getEmail());
        if (user == null) {
            // Nếu chưa có user, tạo mới
            user = new Users();
            user.setFullName(googleUser.getName());
            user.setEmail(googleUser.getEmail());
            user.setPassword(""); // Google login không cần password
            user.setRoleId(2);    // role user
            userDao.insert(user);
        }

        // Login thành công, lưu session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        response.sendRedirect("Home.jsp"); // chuyển đến trang chính
    }
}