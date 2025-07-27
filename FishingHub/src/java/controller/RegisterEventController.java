package controller;

import dal.EventDAO;
import dal.FishSpeciesDAO;
import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import model.EventParticipant;
import model.Events;
import model.FishSpecies;
import model.Post;
import model.Users;

/**
 * Servlet for handling event registration and cancellation.
 */
public class RegisterEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        String action = request.getParameter("action");
        String redirectTo = request.getParameter("redirectTo");
        EventDAO dao = new EventDAO();

        if ("register".equals(action) || "cancel".equals(action)) {
            handleEventAction(request, response, action, user, redirectTo, dao);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String redirectTo = request.getParameter("redirectTo");
        EventDAO dao = new EventDAO();

        if ("register".equals(action) || "cancel".equals(action)) {
            handleEventAction(request, response, action, user, redirectTo, dao);
        }
    }

    private void handleEventAction(HttpServletRequest request, HttpServletResponse response, String action,
            Users user, String redirectTo, EventDAO dao)
            throws ServletException, IOException {

        String targetPage = "Event.jsp";
        boolean topOnly = false;

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));

            if ("register".equals(action)) {

                if (dao.isEventFull(eventId)) {
                    request.setAttribute("error", "Sự kiện đã đạt số lượng người tham gia tối đa.");
                } else if (dao.isUserRegistered(eventId, user.getUserId())) {
                    request.setAttribute("error", "Bạn đã đăng ký tham gia sự kiện này rồi.");
                } else {
                    String phoneNumber = request.getParameter("phoneNumber");
                    String email = request.getParameter("email");
                    String cccd = request.getParameter("cccd");

                    Pattern phonePattern = Pattern.compile("^0[0-9]{9}$");

                    Pattern emailPattern = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");

                    Pattern cccdPattern = Pattern.compile("^[0-9]{12}$");

                    if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
                        request.setAttribute("error", "Số điện thoại không được để trống.");
                    } else if (!phonePattern.matcher(phoneNumber).matches()) {
                        request.setAttribute("error",
                                "Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại 10 chữ số bắt đầu bằng 0.");
                    } else if (email == null || email.trim().isEmpty()) {
                        request.setAttribute("error", "Email không được để trống.");
                    } else if (!emailPattern.matcher(email).matches()) {
                        request.setAttribute("error", "Email không hợp lệ.");
                    } else if (cccd != null && !cccd.trim().isEmpty() && !cccdPattern.matcher(cccd).matches()) {
                        request.setAttribute("error", "CCCD không hợp lệ.");
                    } else {
                        EventParticipant ep = new EventParticipant();
                        ep.setEventId(eventId);
                        ep.setUserId(user.getUserId());
                        ep.setNumberPhone(phoneNumber);
                        ep.setEmail(email);
                        ep.setCccd(cccd != null ? cccd.trim() : null);

                        if (dao.register(ep) != null) {
                            request.setAttribute("success", "Đăng ký sự kiện thành công!");
                        } else {
                            request.setAttribute("error", "Đăng ký sự kiện thất bại.");
                        }
                    }
                }

            } else if ("cancel".equals(action)) {
                if (!dao.isUserRegistered(eventId, user.getUserId())) {
                    request.setAttribute("error", "Bạn chưa đăng ký sự kiện này.");
                } else if (dao.cancelRegistration(eventId, user.getUserId())) {
                    request.setAttribute("success", "Hủy đăng ký sự kiện thành công!");
                } else {
                    request.setAttribute("error", "Hủy đăng ký sự kiện thất bại.");
                }
            }

        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "ID sự kiện không hợp lệ.");
        } catch (Exception ex) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + ex.getMessage());
        }

        if ("home".equalsIgnoreCase(redirectTo)) {
            targetPage = "Home.jsp";
            topOnly = true;
        }

        loadEventList(request, user, dao, topOnly);
        request.getRequestDispatcher(targetPage).forward(request, response);
    }

    private void loadEventList(HttpServletRequest request, Users user, EventDAO dao, boolean topOnly) {
        ArrayList<Events> list;
        if (topOnly) {
            list = dao.getEventsOnTop();
        } else {
            list = dao.getEvents();
        }

        ArrayList<Boolean> isRegisteredList = new ArrayList<>();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        for (Events event : list) {
            String status;
            if (now.before(event.getStartTime())) {
                status = "Sắp diễn ra";
            } else if (now.after(event.getEndTime())) {
                status = "Đã kết thúc";
            } else {
                status = "Đang diễn ra";
            }
            event.setEventStatus(status);
            isRegisteredList.add(dao.isUserRegistered(event.getEventId(), user.getUserId()));
        }

        request.setAttribute("listE", list);
        request.setAttribute("isRegisteredList", isRegisteredList);

        PostDAO postDAO = new PostDAO();
        List<Post> recentPosts = postDAO.getRecentPosts(2);
        request.setAttribute("recentPosts", recentPosts);

        // Lấy 3 loài cá đại diện cho 3 mức độ khó
        FishSpeciesDAO fishDAO = new FishSpeciesDAO();
        List<FishSpecies> representativeFish = new ArrayList<>();
        try {
            FishSpecies easyFish = fishDAO.getFishByDifficultyLevel(1);
            if (easyFish != null)
                representativeFish.add(easyFish);
            FishSpecies mediumFish = fishDAO.getFishByDifficultyLevel(2);
            if (mediumFish != null)
                representativeFish.add(mediumFish);
            FishSpecies hardFish = fishDAO.getFishByDifficultyLevel(3);
            if (hardFish != null)
                representativeFish.add(hardFish);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("representativeFish", representativeFish);
    }

    @Override
    public String getServletInfo() {
        return "Handles event registration and cancellation for the FishingHub application.";
    }
}