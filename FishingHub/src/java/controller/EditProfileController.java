package controller;

import dal.UserDao;
import model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "EditProfileController", urlPatterns = {"/EditProfileController"})
public class EditProfileController extends HttpServlet {

    private UserDao userDB = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Kiểm tra 30 ngày
        java.sql.Timestamp lastUpdate = user.getLastProfileUpdate();
        long now = System.currentTimeMillis();
        if (lastUpdate != null) {
            long diffDays = (now - lastUpdate.getTime()) / (1000 * 60 * 60 * 24);
            if (diffDays < 30) {
                request.getSession().setAttribute("successMessage", "Bạn chỉ được phép cập nhật hồ sơ sau mỗi 30 ngày. Vui lòng thử lại sau " + (30 - diffDays) + " ngày nữa.");
                response.sendRedirect("Profile");
                return;
            }
        }

        // Lấy dữ liệu mới từ form
        String fullName = request.getParameter("fullName");
        String location = request.getParameter("location");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dateOfBirth");

        user.setFullName(fullName);
        user.setLocation(location);
        if (phone != null) user.setPhone(phone);
        if (gender != null) user.setGender(gender);
        if (dob != null && !dob.trim().isEmpty()) user.setDateOfBirth(java.sql.Date.valueOf(dob));
        user.setLastProfileUpdate(new java.sql.Timestamp(now));

        // Cập nhật vào database
        boolean updateSuccess = false;
        try {
            userDB.update(user);
            updateSuccess = true;
        } catch (Exception ex) {
            ex.printStackTrace();
            updateSuccess = false;
        }

        // Cập nhật lại session
        request.getSession().setAttribute("user", user);

        // Thông báo thành công/thất bại
        if (updateSuccess) {
            request.getSession().setAttribute("successMessage", "Cập nhật thông tin thành công!");
        } else {
            request.getSession().setAttribute("successMessage", "Có lỗi khi cập nhật. Vui lòng thử lại sau!");
        }
        response.sendRedirect("Profile");
    }
}