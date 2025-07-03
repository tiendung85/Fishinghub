package controller;

import dal.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.regex.Pattern;
import model.EventParticipant;
import model.Events;
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
        EventDAO dao = new EventDAO();

        if ("register".equals(action) || "cancel".equals(action)) {
            handleEventAction(request, response, action, user, dao);
        } else {
            loadEventList(request, user, dao);
            request.getRequestDispatcher("Event.jsp").forward(request, response);
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
        EventDAO dao = new EventDAO();

        if ("register".equals(action) || "cancel".equals(action)) {
            handleEventAction(request, response, action, user, dao);
        } else {
            loadEventList(request, user, dao);
            request.getRequestDispatcher("Event.jsp").forward(request, response);
        }
    }

    private void handleEventAction(HttpServletRequest request, HttpServletResponse response, String action, Users user, EventDAO dao)
            throws ServletException, IOException {
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
                    String cccd = request.getParameter("cccd"); // Lấy CCCD nếu có

                    if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
                        request.setAttribute("error", "Số điện thoại không được để trống.");
                        loadEventList(request, user, dao);
                        request.getRequestDispatcher("Event.jsp").forward(request, response);
                        return;
                    }

                    if (email == null || email.trim().isEmpty()) {
                        request.setAttribute("error", "Email không được để trống.");
                        loadEventList(request, user, dao);
                        request.getRequestDispatcher("Event.jsp").forward(request, response);
                        return;
                    }

                    Pattern phonePattern = Pattern.compile("^0[0-9]{9}$");
                    if (!phonePattern.matcher(phoneNumber).matches()) {
                        request.setAttribute("error", "Số điện thoại không hợp lệ. Vui lòng nhập số điện thoại 10 chữ số bắt đầu bằng 0.");
                        loadEventList(request, user, dao);
                        request.getRequestDispatcher("Event.jsp").forward(request, response);
                        return;
                    }

                    Pattern emailPattern = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
                    if (!emailPattern.matcher(email).matches()) {
                        request.setAttribute("error", "Email không hợp lệ.");
                        loadEventList(request, user, dao);
                        request.getRequestDispatcher("Event.jsp").forward(request, response);
                        return;
                    }

                    EventParticipant ep = new EventParticipant();
                    ep.setEventId(eventId);
                    ep.setUserId(user.getUserId());
                    ep.setNumberPhone(phoneNumber);
                    ep.setEmail(email);
                    ep.setCccd(cccd);

                    if (dao.register(ep) != null) {
                        request.setAttribute("success", "Đăng ký sự kiện thành công!");
                    } else {
                        request.setAttribute("error", "Đăng ký sự kiện thất bại.");
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
            request.setAttribute("error", "ID sự kiện hoặc số điện thoại không hợp lệ.");
        } catch (Exception ex) {
            request.setAttribute("error", "Đã xảy ra lỗi: " + ex.getMessage());
        }

        loadEventList(request, user, dao);
        request.getRequestDispatcher("Event.jsp").forward(request, response);
    }

    private void loadEventList(HttpServletRequest request, Users user, EventDAO dao) {
        ArrayList<Events> list = dao.getEvents();
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
    }

    @Override
    public String getServletInfo() {
        return "Handles event registration and cancellation for the FishingHub application.";
    }
}
