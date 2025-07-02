package controller;

import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "DeleteUserController", urlPatterns = {"/deleteUser"})
public class DeleteUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userIdStr = request.getParameter("userId");
        if (userIdStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                UserDao dao = new UserDao();
                dao.delete(userId); // Hàm này bạn đã có sẵn
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // Quay lại UserManager sau khi xóa
        response.sendRedirect("UserManager");
    }
}
