package controller;

import dal.UserDao;
import dal.UserPermissionDAO; // Đã đổi tên từ PermissionDAO sang UserPermissionDAO
import model.Users;
import model.Permission;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "EditUserController", urlPatterns = {"/EditUser"})
public class EditUserController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int userId;
        try {
            userId = Integer.parseInt(req.getParameter("userId"));
        } catch (Exception e) {
            resp.sendRedirect("UserManager");
            return;
        }
        UserDao userDao = new UserDao();
        Users user = userDao.getUserById(userId);
        if (user == null) {
            resp.sendRedirect("UserManager");
            return;
        }

        UserPermissionDAO permDao = new UserPermissionDAO();
        List<Permission> allPermissions = permDao.getPermissionsByRole(user.getRoleId());
        List<Integer> deniedPermissions = permDao.getDeniedPermissionsByUser(userId);

        // Truyền sang JSP dưới dạng Set để JSTL contains hoạt động tốt
        Set<Integer> deniedPermissionsSet = new HashSet<>(deniedPermissions);

        req.setAttribute("user", user);
        req.setAttribute("allPermissions", allPermissions);
        req.setAttribute("deniedPermissionsSet", deniedPermissionsSet);

        req.getRequestDispatcher("EditUser.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        int userId = Integer.parseInt(req.getParameter("userId"));
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String gender = req.getParameter("gender");
        String dob = req.getParameter("dob");
        String location = req.getParameter("location");
        int roleId = Integer.parseInt(req.getParameter("roleId"));

        // Update user info
        Users user = new Users();
        user.setUserId(userId);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setGender(gender);
        user.setDateOfBirth(java.sql.Date.valueOf(dob));
        user.setLocation(location);
        user.setRoleId(roleId);

        UserDao userDao = new UserDao();
        userDao.update(user);

        // Cập nhật quyền bị cấm
        String[] deniedArr = req.getParameterValues("denyPermission");
        List<Integer> deniedIds = new ArrayList<>();
        if (deniedArr != null) {
            for (String s : deniedArr) {
                try {
                    deniedIds.add(Integer.parseInt(s));
                } catch (Exception ex) {}
            }
        }
        UserPermissionDAO permDao = new UserPermissionDAO();
        permDao.setDeniedPermissions(userId, deniedIds);

        resp.sendRedirect("UserManager");
    }
}
