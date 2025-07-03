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

import java.util.ArrayList;
import model.EventParticipant;

import model.Users;

/**
 *
 * @author LENOVO
 */
public class EventParticipantsController extends HttpServlet {

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
            out.println("<title>Servlet EventParticipantsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventParticipantsController at " + request.getContextPath() + "</h1>");
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
                ArrayList<EventParticipant> list = new ArrayList<>();
                list = dao.getParticipantsByEventId(eventId);
                request.setAttribute("listEP", list);
                request.setAttribute("eventId", eventId);
                request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
            } else if (action.equals("list")) {
                ArrayList<EventParticipant> list = new ArrayList<>();
                list = dao.getParticipantsByEventId(eventId);
                request.setAttribute("listEP", list);
                request.setAttribute("eventId", eventId);
                request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
            } else if (action.equals("search")) {
                String search = request.getParameter("keyword");
                ArrayList<EventParticipant> allParticipants = dao.getParticipantsByEventId(eventId);
                ArrayList<EventParticipant> resultList = new ArrayList<>();

                if (search != null && !search.trim().isEmpty()) {
                    for (EventParticipant ep : allParticipants) {
                        if ((ep.getFullName() != null && ep.getFullName().toLowerCase().contains(search.toLowerCase()))
                                || (ep.getEmail() != null && ep.getEmail().toLowerCase().contains(search.toLowerCase())) 
                                || (ep.getCccd() != null && ep.getCccd().toLowerCase().contains(search.toLowerCase()))
                                || (ep.getNumberPhone() != null && ep.getNumberPhone().toLowerCase().contains(search.toLowerCase()))){
                            resultList.add(ep);
                        }
                    }
                } else {
                    resultList = allParticipants;
                }
                request.setAttribute("search", search);
                request.setAttribute("listEP", resultList);
                request.setAttribute("eventId", eventId);
                request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
            } else if (action.equals("filter")) {
                String status = request.getParameter("status");
                ArrayList<EventParticipant> list = new ArrayList<>();

                if (status == null || status.isEmpty()) {
                    list = dao.getParticipantsByEventId(eventId);
                } else {
                    boolean checkinStatus = status.equals("1");
                    list = dao.filterParticipantsByCheckin(eventId, checkinStatus);
                }
                request.setAttribute("status", status);
                request.setAttribute("listEP", list);
                request.setAttribute("eventId", eventId);
                request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
            } else if (action.equals("checkin")) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                boolean updated = dao.updateCheckIn(eventId, userId);
                if (updated) {
                    request.setAttribute("success", "Check-in thành công!");
                } else {
                    request.setAttribute("error", "Check-in thất bại!");
                }
                ArrayList<EventParticipant> list = dao.getParticipantsByEventId(eventId);
                request.setAttribute("listEP", list);
                request.setAttribute("eventId", eventId);
                request.getRequestDispatcher("dashboard_owner/EventParticipants.jsp").forward(request, response);
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