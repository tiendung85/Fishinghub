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
import model.Events;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class EventListController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
<<<<<<< HEAD
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
=======
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
>>>>>>> origin/NgocDung
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EventListController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventListController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

<<<<<<< HEAD
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
=======
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
>>>>>>> origin/NgocDung
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
<<<<<<< HEAD
        String action = request.getParameter("action");
        EventDAO dao = new EventDAO();

        ArrayList<Events> list;
        if (action == null) {
            list = dao.getEvents();
        } else if (action.equals("upcoming")) {
            list = dao.upComingEvents();
        } else if (action.equals("ongoing")) {
            list = dao.getOngoingEvents();
        } else if (action.equals("saved")) {
            list = dao.getSavedEvents(user.getUserId());
        } else {
            list = new ArrayList<>();
        }

        Timestamp now = new Timestamp(System.currentTimeMillis());
        ArrayList<Boolean> isRegisteredList = new ArrayList<>();

=======

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        EventDAO dao = new EventDAO();
        ArrayList<Events> list = new ArrayList<>();

        Timestamp now = new Timestamp(System.currentTimeMillis());

        if (action == null || action.equals("all")) {
            list = dao.getEvents(user.getUserId());
        } else if (action.equals("upcoming")) {
            list = dao.upComingEvents(user.getUserId()); // tạo thêm hàm này trong DAO
        } 
         else if (action.equals("ongoing")) {
            list = dao.getOngoingEvents(user.getUserId()); // tạo thêm hàm này trong DAO
        } 

        // Xác định trạng thái và đăng ký của user cho từng event
        ArrayList<Boolean> isRegisteredList = new ArrayList<>();
>>>>>>> origin/NgocDung
        for (Events e : list) {
            if (now.before(e.getStartTime())) {
                e.setEventStatus("Sắp diễn ra");
            } else if (now.after(e.getEndTime())) {
                e.setEventStatus("Đã kết thúc");
            } else {
                e.setEventStatus("Đang diễn ra");
            }

<<<<<<< HEAD
            boolean isRegistered = false;
            if (user != null) {
                isRegistered = dao.isUserRegistered(e.getEventId(), user.getUserId());
            }
=======
            boolean isRegistered = dao.isUserRegistered(e.getEventId(), user.getUserId());
>>>>>>> origin/NgocDung
            isRegisteredList.add(isRegistered);
        }

        request.setAttribute("listE", list);
        request.setAttribute("isRegisteredList", isRegisteredList);
        request.getRequestDispatcher("Event.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
<<<<<<< HEAD
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
=======
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
>>>>>>> origin/NgocDung
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

<<<<<<< HEAD
}
=======
}
>>>>>>> origin/NgocDung
