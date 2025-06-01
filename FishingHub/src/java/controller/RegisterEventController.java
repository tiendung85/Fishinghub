/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.ArrayList;
import model.EventParticipant;
import model.Events;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class RegisterEventController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterEventController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterEventController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        if ("register".equals(action)) {
            handleRegistration(request, response);
        } else {
            response.sendRedirect("EventList");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        } else {
            if (action != null) {
                request.getRequestDispatcher("Event.jsp").forward(request, response);
            } else if ("register".equals(action)) {
                handleRegistration(request, response);
            }
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        EventDAO dao = new EventDAO();

        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));

            // Check if event is full
            if (dao.isEventFull(eventId)) {
                request.setAttribute("error", "Sự kiện đã đạt số lượng người tham gia tối đa.");
            } // Check if user is already registered
            else if (dao.isUserRegistered(eventId, user.getUserId())) {
                request.setAttribute("error", "Bạn đã đăng ký tham gia sự kiện này rồi.");
            } // Register user to the event
            else {
                EventParticipant ep = new EventParticipant();
                ep.setEventId(eventId);
                ep.setUserId(user.getUserId());

                EventParticipant result = dao.register(ep);
                if (result != null) {
                    request.setAttribute("success", "Đăng ký sự kiện thành công!");
                } else {
                    request.setAttribute("error", "Đăng ký sự kiện thất bại.");
                }
            }
        } catch (NumberFormatException nfe) {
            request.setAttribute("error", "ID sự kiện không hợp lệ.");
        } catch (Exception ex) {
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đăng ký: " + ex.getMessage());
        }

        // Always reload the event list and forward
        loadEventList(request, user, dao);
        request.getRequestDispatcher("Event.jsp").forward(request, response);
    }

    private void loadEventList(HttpServletRequest request, Users user, EventDAO dao) {
        ArrayList<Events> list = dao.getEvents(user.getUserId());
        ArrayList<Boolean> isRegisteredList = new ArrayList<>();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        for (Events event : list) {
            if (now.before(event.getStartTime())) {
                event.setEventStatus("Sắp diễn ra");
            } else if (now.after(event.getEndTime())) {
                event.setEventStatus("Đã kết thúc");
            } else {
                event.setEventStatus("Đang diễn ra");
            }

            boolean isRegistered = dao.isUserRegistered(event.getEventId(), user.getUserId());
            isRegisteredList.add(isRegistered);
        }

        request.setAttribute("listE", list);
        request.setAttribute("isRegisteredList", isRegisteredList);
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
