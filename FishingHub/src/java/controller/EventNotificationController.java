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
import model.EventNotification;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class EventNotificationController extends HttpServlet {

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
            out.println("<title>Servlet EventNotificationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventNotificationController at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        String action = request.getParameter("action");
        EventDAO dao = new EventDAO();
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        if (user == null) {
            response.sendRedirect("login");
        } else {
            if (action == null) {
                
                request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
            } else if (action.equals("sendinfo")) {
                request.setAttribute("eventId", eventId);
                request.getRequestDispatcher("dashboard_owner/EventNotification.jsp").forward(request, response);
            } else if (action.equals("sendnotification")) {
                try {
                    int id = Integer.parseInt(request.getParameter("eventId"));
                    String title = request.getParameter("title");
                    String mes = request.getParameter("content");

                    EventNotification notification = new EventNotification();
                    notification.setSenderId(user.getUserId());
                    notification.setEventId(id);
                    notification.setTitle(title);
                    notification.setMessage(mes);

                    EventNotification inserted = dao.insertNotification(notification);

                    if (inserted != null) {
                        request.setAttribute("success", "Gửi thông báo thành công.");
                        request.setAttribute("noti", inserted);
                    } else {
                        request.setAttribute("error", "Gửi thông báo thất bại.");
                    }
                     request.setAttribute("eventId", id); 
                } catch (Exception e) {
                    request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
                }
                request.getRequestDispatcher("dashboard_owner/EventNotification.jsp").forward(request, response);
            }
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
        processRequest(request, response);
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
