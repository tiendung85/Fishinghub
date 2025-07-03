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
        // Phân quyền: chỉ cho admin vào
        Users currentUser = (Users) request.getSession().getAttribute("user");
        if (currentUser == null || currentUser.getRoleId() != 3) { // 3 là Admin
            response.sendRedirect("Login.jsp");
            return;
        }

        // Lấy action từ request
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            // Nếu action là "view", lấy userId và hiển thị chi tiết người dùng
            int userId = Integer.parseInt(request.getParameter("userId"));
            UserDao userDao = new UserDao();
            Users user = userDao.getUserById(userId); // Lấy người dùng theo ID từ DB

            // Lưu đối tượng user vào request để hiển thị trên ViewUser.jsp
            request.setAttribute("user", user);

            // Forward sang trang ViewUser.jsp để hiển thị thông tin chi tiết
            request.getRequestDispatcher("ViewUser.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            UserDao userDao = new UserDao();
            Users user = userDao.getUserById(userId); // Lấy người dùng theo ID từ DB

            // Đưa đối tượng user vào request để hiển thị trên EditUser.jsp
            request.setAttribute("user", user);

            // Forward sang trang EditUser.jsp để hiển thị thông tin chỉnh sửa
            request.getRequestDispatcher("EditUser.jsp").forward(request, response);
            return;
        }

        // Lấy các tham số tìm kiếm từ request
        String searchQuery = request.getParameter("searchQuery");
        String roleFilter = request.getParameter("role");

        // Lấy danh sách user từ cơ sở dữ liệu, lọc theo tên và vai trò
        UserDao userDao = new UserDao();
        List<Users> userList = userDao.listFiltered(searchQuery, roleFilter); // Sử dụng phương thức lọc

        // Tính trạng thái người dùng (Active/Inactive)
        for (Users user : userList) {
            if (user.getLastLoginTime() != null) {
                long timeDifference = System.currentTimeMillis() - user.getLastLoginTime().getTime();
                if (timeDifference <= 48 * 60 * 60 * 1000L) { // Nếu đăng nhập trong 48 giờ
                    user.setStatus("Active");
                } else {
                    user.setStatus("Inactive");
                }
            } else {
                user.setStatus("Inactive"); // Nếu không có thông tin lần đăng nhập trước
            }
        }

        // Lưu danh sách người dùng vào request
        request.setAttribute("userList", userList); // Đảm bảo lưu lại danh sách người dùng vào request

        // Forward sang trang quản lý user
        request.getRequestDispatcher("UserManager.jsp").forward(request, response); // Chuyển đến JSP
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy action từ form
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            UserDao userDao = new UserDao();
            userDao.delete(userId); // Xóa người dùng từ database
        }

        // Sau khi thực hiện xóa, chuyển hướng về trang quản lý người dùng
        response.sendRedirect("UserManager");
    }
}