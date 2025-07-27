/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Events;
import model.Users;

/**
 *
 * @author LENOVO
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class EventUpdateController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EventUpdateController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventUpdateController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String action = request.getParameter("action");
        int eventid = Integer.parseInt(request.getParameter("eventId"));
        EventDAO dao = new EventDAO();

        if (user == null) {
            response.sendRedirect("login");
        } else {
            if (action == null) {
                response.sendRedirect("EventManager");
            } else if (action.equals("event")) {
                Events event = dao.getUpdateEvents(eventid);
                request.setAttribute("event", event);
                request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if (!"update".equals(action)) {
            request.setAttribute("error", "Hành động không hợp lệ.");
            request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
            return;
        }

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String title = request.getParameter("title");
            String lakeName = request.getParameter("lakeName");
            String description = request.getParameter("description");
            String location = request.getParameter("location");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            String maxParticipantsStr = request.getParameter("maxParticipants");

            Events event = new Events();
            event.setEventId(eventId);
            event.setTitle(title);
            event.setLakeName(lakeName);
            event.setDescription(description);
            event.setLocation(location);
            event.setMaxParticipants(maxParticipantsStr != null ? Integer.parseInt(maxParticipantsStr) : 0);
            event.setHostId(user.getUserId());
            event.setStatus("pending");
            event.setCurrentParticipants(0);

            // Kiểm tra các trường bắt buộc
            if (title == null || title.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || location == null || location.trim().isEmpty()
                    || startTimeStr == null || endTimeStr == null || maxParticipantsStr == null) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
                return;
            }

            Timestamp startTime, endTime;
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date parsedStart = dateFormat.parse(startTimeStr);
            Date parsedEnd = dateFormat.parse(endTimeStr);
            startTime = new Timestamp(parsedStart.getTime());
            endTime = new Timestamp(parsedEnd.getTime());
            event.setStartTime(startTime);
            event.setEndTime(endTime);

            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            if (startTime.before(currentTime)) {
                request.setAttribute("error", "Thời gian bắt đầu không được trong quá khứ.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
                return;
            }
            if (endTime.before(startTime) || endTime.equals(startTime)) {
                request.setAttribute("error", "Thời gian kết thúc phải sau thời gian bắt đầu và không được trùng.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
                return;
            }

            int maxParticipants = Integer.parseInt(maxParticipantsStr);
            if (maxParticipants < 1) {
                request.setAttribute("error", "Số người tham gia tối đa phải lớn hơn 0.");
                request.setAttribute("event", event);
                request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
                return;
            }

            // Xử lý file ảnh
            String posterUrl = null;
            Part filePart = request.getPart("posterFile");
            EventDAO dao = new EventDAO();
            Events oldEvent = dao.getUpdateEvents(eventId);
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String contentType = filePart.getContentType();
                if (!contentType.startsWith("image/")) {
                    request.setAttribute("error", "Chỉ cho phép tải lên file ảnh.");
                    request.setAttribute("event", event);
                    event.setPosterUrl(oldEvent.getPosterUrl());
                    request.setAttribute("event", event);
                    request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
                    return;
                }

                String uploadPath = "C:\\Users\\pc\\Desktop\\SWP\\Dung\\Fishinghub\\web\\assets\\img\\eventPoster";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                posterUrl = fileName;
            } else {
                posterUrl = oldEvent.getPosterUrl();
            }
            event.setPosterUrl(posterUrl);

            // Cập nhật sự kiện
            Events updated = dao.updateEvent(event);
            if (updated != null) {
                request.setAttribute("success", "Cập nhật sự kiện thành công.");
                request.setAttribute("event", updated);
            } else {
                request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
                request.setAttribute("event", event);
            }

            request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý: " + e.getMessage());
            request.getRequestDispatcher("dashboard_owner/EventUpdate.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
