package controller;

import dal.PostDAO;
import dal.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // cần import dòng này
import java.io.IOException;
import java.util.List;
import model.Post;

@WebServlet(name = "DashboardStatsServlet", urlPatterns = {"/dashboard-stats"})
public class DashboardStatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // === CHECK ADMIN LOGIN ===
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("roleId") == null
                || !Integer.valueOf(3).equals(session.getAttribute("roleId"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDao userDao = new UserDao();
        PostDAO postDao = new PostDAO();

        // New users in the last 7 days
        int newUsersThisWeek = userDao.countNewUsersInLastWeek();

        // New users in the previous week (from 8 to 14 days ago)
        int newUsersPreviousWeek = userDao.countNewUsersInPreviousWeek();

        // Calculate growth rate (always below 100%)
        double growthRate = 0;
        if (newUsersPreviousWeek > 0) {
            growthRate = ((double) (newUsersThisWeek - newUsersPreviousWeek) / newUsersPreviousWeek) * 100;
            if (growthRate > 99.9) {
                growthRate = 99.9;
            }
            if (growthRate < -99.9) {
                growthRate = -99.9;
            }
        } else if (newUsersThisWeek > 0) {
            growthRate = 99.9;
        } else {
            growthRate = 0;
        }

        request.setAttribute("newUsers", newUsersThisWeek);
        request.setAttribute("percentChange", growthRate);

        // Pending Posts
        int pendingPostsThisWeek = postDao.countPendingPostsThisWeek();
        int pendingPostsPreviousWeek = postDao.countPendingPostsPreviousWeek();

        double pendingPostsChange = 0;
        if (pendingPostsPreviousWeek > 0) {
            pendingPostsChange = ((double) (pendingPostsThisWeek - pendingPostsPreviousWeek) / pendingPostsPreviousWeek) * 100;
            if (pendingPostsChange > 99.9) {
                pendingPostsChange = 99.9;
            }
            if (pendingPostsChange < -99.9) {
                pendingPostsChange = -99.9;
            }
        } else if (pendingPostsThisWeek > 0) {
            pendingPostsChange = 99.9;
        } else {
            pendingPostsChange = 0;
        }

        request.setAttribute("pendingPosts", pendingPostsThisWeek);
        request.setAttribute("pendingPostsChange", pendingPostsChange);

        // === USER BY ROLE ===
        int countUser = userDao.countUserByRole("User");
        int countFishingOwner = userDao.countUserByRole("FishingOwner");
        int countAdmin = userDao.countUserByRole("Admin");
        request.setAttribute("countUser", countUser);
        request.setAttribute("countFishingOwner", countFishingOwner);
        request.setAttribute("countAdmin", countAdmin);

        int totalUsers = userDao.countAllUsers();
        request.setAttribute("totalUsers", totalUsers);

        List<Post> topPendingPosts = postDao.getTopPendingPosts(4);
        request.setAttribute("topPendingPosts", topPendingPosts);

        System.out.println("SIZE: " + (topPendingPosts == null ? "null" : topPendingPosts.size()));

        // Other dashboard data...
        request.getRequestDispatcher("dashboard_admin/Dashboard.jsp").forward(request, response);
    }
}