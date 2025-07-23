/*
 * EventController handles event creation and related operations.
 */
package controller;

import dal.EventDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Events;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Users;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50) 
public class EventController extends HttpServlet {

    private static final String UPLOAD_DIR = "assets/img/eventPoster";
    private static final String DATE_FORMAT = "yyyy-MM-dd'T'HH:mm";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
        } else {
            String action = request.getParameter("action");
            if (action == null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("EventList");
                dispatcher.forward(request, response);
            } else if (action.equals("create_event")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("EventForm.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
        } else {
            if (!"add".equals(action)) {
                request.setAttribute("error", "Invalid action specified.");
                request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                return;
            }

            String title = request.getParameter("title");
            String lakeName = request.getParameter("lakeName");
            String description = request.getParameter("description");
            String location = request.getParameter("location");
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            String maxParticipantsStr = request.getParameter("maxParticipants");

            if (title == null || description == null || location == null
                    || startTimeStr == null || endTimeStr == null || maxParticipantsStr == null
                    || title.trim().isEmpty() || description.trim().isEmpty() || location.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ tất cả các trường thông tin.");
                request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                return;
            }

            Timestamp startTime = null;
            Timestamp endTime = null;
            int maxParticipants;

            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_FORMAT);
                dateFormat.setLenient(false);
                Date parsedStart = dateFormat.parse(startTimeStr);
                Date parsedEnd = dateFormat.parse(endTimeStr);
                startTime = new Timestamp(parsedStart.getTime());
                endTime = new Timestamp(parsedEnd.getTime());

                Timestamp now = new Timestamp(System.currentTimeMillis());
                if (startTime.before(now)) {
                    request.setAttribute("error", "Start time must not be in the past.");
                    request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                    return;
                }

                if (endTime.before(startTime)) {
                    request.setAttribute("error", "End time must be after start time.");
                    request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                    return;
                }

                maxParticipants = Integer.parseInt(maxParticipantsStr);
                if (maxParticipants < 1) {
                    request.setAttribute("error", "Max participants must be at least 1.");
                    request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format or number format.");
                request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                return;
            }

            String posterUrl = null;
            Part filePart = request.getPart("posterFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (!fileName.isEmpty()) {

                    String contentType = filePart.getContentType();
                    if (!contentType.startsWith("image/")) {
                        request.setAttribute("error", "Only image files are allowed.");
                        request.getRequestDispatcher("EventForm.jsp").forward(request, response);
                        return;
                    }

                    String uploadPath = "G:\\SWP\\FishingHub\\Fishinghub\\Fishinghub\\web" + File.separator + UPLOAD_DIR;

                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    posterUrl = fileName;
                }
            }

            Events event = new Events();
            event.setTitle(title);
            event.setLakeName(lakeName);
            event.setDescription(description);
            event.setLocation(location);
            event.setHostId(user.getUserId());
            event.setStartTime(startTime);
            event.setEndTime(endTime);
            event.setStatus("pending");
            event.setPosterUrl(posterUrl);
            event.setMaxParticipants(maxParticipants);
            event.setCurrentParticipants(0);

            EventDAO dao = new EventDAO();
            Events result = dao.addEvent(event);
            if (result != null) {
                request.setAttribute("success", "Event created successfully!");
            } else {
                request.setAttribute("error", "Failed to create event.");
            }

            request.getRequestDispatcher("EventForm.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles event creation and management.";
    }

}