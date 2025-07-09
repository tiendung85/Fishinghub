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
public class EventManagerController extends HttpServlet {

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
            out.println("<title>Servlet EventManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventManagerController at " + request.getContextPath() + "</h1>");
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
        String search = request.getParameter("search");
        EventDAO dao = new EventDAO();

        ArrayList<Events> list = new ArrayList<>();
        if (user == null) {
            response.sendRedirect("login");
        } else {
            if (action == null) {
                list = dao.getEvents(user.getUserId());
                Timestamp now = new Timestamp(System.currentTimeMillis());
                for (Events e : list) {
                    if (now.before(e.getStartTime())) {
                        e.setEventStatus("Sắp diễn ra");
                    } else if (now.after(e.getEndTime())) {
                        e.setEventStatus("Đã kết thúc");
                    } else {
                        e.setEventStatus("Đang diễn ra");
                    }
                }
                request.setAttribute("listE", list);
                request.getRequestDispatcher("dashboard_owner/EventManager.jsp").forward(request, response);

            } else if (action.equals("search")) {
                ArrayList<Events> allEvents = dao.getEvents(user.getUserId());
                ArrayList<Events> resultList = new ArrayList<>();
                Timestamp now = new Timestamp(System.currentTimeMillis());
                if (search != null && !search.trim().isEmpty()) {
                    for (Events e : allEvents) {
                        if (e.getTitle().toLowerCase().contains(search.toLowerCase())) {
                            resultList.add(e);
                        }
                        if (e.getLocation().toLowerCase().contains(search.toLowerCase())) {
                            resultList.add(e);
                        }

                    }
                } else {
                    resultList = allEvents;
                }
                for (Events e : allEvents) {
                    if (now.before(e.getStartTime())) {
                        e.setEventStatus("Sắp diễn ra");
                    } else if (now.after(e.getEndTime())) {
                        e.setEventStatus("Đã kết thúc");
                    } else {
                        e.setEventStatus("Đang diễn ra");
                    }
                }
                request.setAttribute("search", search);
                request.setAttribute("listE", resultList);
                request.getRequestDispatcher("dashboard_owner/EventManager.jsp").forward(request, response);
            } else if (action.equals("filter")) {
                String statusFilter = request.getParameter("status");
                ArrayList<Events> allEvents = dao.getEvents(user.getUserId());
                ArrayList<Events> filteredEvents = new ArrayList<>();

                Timestamp now = new Timestamp(System.currentTimeMillis());

                for (Events e : allEvents) {
                    if ("upcoming".equals(statusFilter) && e.getStartTime().after(now) && e.getStatus().equals("approved")) {
                        filteredEvents.add(e);
                    } else if ("ended".equals(statusFilter) && e.getEndTime().before(now)&& e.getStatus().equals("approved")) {
                        filteredEvents.add(e);
                    } else if ("ongoing".equals(statusFilter) && e.getEndTime().equals(now)&& e.getStatus().equals("approved")) {
                        filteredEvents.add(e);
                    } else if ("pass".equals(statusFilter) && e.getStatus().equals("approved")) {
                        filteredEvents.add(e);
                    } else if ("reject".equals(statusFilter) &&  e.getStatus().equals("rejected")) {
                        filteredEvents.add(e);
                    } else if ("pending".equals(statusFilter) &&  e.getStatus().equals("pending")) {
                        filteredEvents.add(e);
                    } else if ("all".equals(statusFilter)) {
                        filteredEvents = allEvents;
                        break;
                    }
                }

                for (Events e : allEvents) {
                    if (now.before(e.getStartTime())) {
                        e.setEventStatus("Sắp diễn ra");
                    } else if (now.after(e.getEndTime())) {
                        e.setEventStatus("Đã kết thúc");
                    } else {
                        e.setEventStatus("Đang diễn ra");
                    }
                }
                request.setAttribute("filter", statusFilter);
                request.setAttribute("listE", filteredEvents);
                request.getRequestDispatcher("dashboard_owner/EventManager.jsp").forward(request, response);
            } else if (action.equals("delete")) {
                try {
                    int id = Integer.parseInt(request.getParameter("eventId"));
                    boolean deleted = dao.deleteEvent(id);

                    if (deleted) {
                        list = dao.getEvents(user.getUserId());
                        request.setAttribute("listE", list);
                        request.setAttribute("message", "Xóa sự kiện thành công!");
                    } else {
                        request.setAttribute("message", "Không thể xóa sự kiện đã được duyệt hoặc không tồn tại.");
                    }

                    request.getRequestDispatcher("dashboard_owner/EventManager.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("message", "Lỗi khi xóa sự kiện.");
                    request.getRequestDispatcher("dashboard_owner/EventManager.jsp").forward(request, response);
                }
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