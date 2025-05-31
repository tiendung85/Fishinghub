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
import model.EventParticipant;
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
            if(action !=null){
                request.getRequestDispatcher("Event.jsp").forward(request, response);
            }
            else if ("register".equals(action)) {
                handleRegistration(request, response);
            }
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");
            EventDAO dao = new EventDAO();

            // Check if event exists and is not full
            if (dao.isEventFull(eventId)) {
                request.setAttribute("error", "Event has reached maximum participants.");
            } else if (dao.isUserRegistered(eventId, user.getUserId())) {
                request.setAttribute("error", "You are already registered for this event.");
            } else {
                EventParticipant ep = new EventParticipant();
                ep.setEventId(eventId);
                ep.setUserId(user.getUserId());

                EventParticipant result = dao.register(ep);
                if (result != null) {
                    request.setAttribute("success", "Successfully registered for the event!");
                } else {
                    request.setAttribute("error", "Failed to register for the event.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid event ID.");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration: " + e.getMessage());
        }
        request.getRequestDispatcher("EventList").forward(request, response);
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
