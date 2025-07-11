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
public class AdminEventManagerController extends HttpServlet {

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
            out.println("<title>Servlet AdminEventManagerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminEventManagerController at " + request.getContextPath() + "</h1>");
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
        ArrayList<Events> list = new ArrayList<>();
        if (user == null) {
            response.sendRedirect("login");
        } else {
            if (action == null) {
                list = dao.getEventsList();
                request.setAttribute("listE", list);
                request.getRequestDispatcher("dashboard_admin/AdminEventManager.jsp").forward(request, response);

            } else if (action.equals("search")) {
                String search = request.getParameter("search");
                ArrayList<Events> allEvents = dao.getEventsList();
                ArrayList<Events> resultList = new ArrayList<>();
                Timestamp now = new Timestamp(System.currentTimeMillis());
                if (search != null && !search.trim().isEmpty()) {
                    for (Events e : allEvents) {
                        if (e.getTitle().toLowerCase().contains(search.toLowerCase())) {
                            resultList.add(e);
                        }
                        if (e.getFullName().toLowerCase().contains(search.toLowerCase())) {
                            resultList.add(e);
                        }
                    }
                } else {
                    resultList = allEvents;
                }
                request.setAttribute("search", search);
                request.setAttribute("listE", resultList);
                request.getRequestDispatcher("dashboard_admin/AdminEventManager.jsp").forward(request, response);
            } else if (action.equals("filter")) {
                String statusFilter = request.getParameter("status");
                ArrayList<Events> allEvents = dao.getEventsList();
                ArrayList<Events> filteredEvents = new ArrayList<>();

                Timestamp now = new Timestamp(System.currentTimeMillis());

                for (Events e : allEvents) {
                    if ("pending".equals(statusFilter) && e.getStatus().equals("pending")) {
                        filteredEvents.add(e);
                    } else if ("rejected".equals(statusFilter) && e.getStatus().equals("rejected")) {
                        filteredEvents.add(e);
                    } else if ("approved".equals(statusFilter) && e.getStatus().equals("approved")) {
                        filteredEvents.add(e);
                    } else if ("all".equals(statusFilter)) {
                        filteredEvents = allEvents;
                        break;
                    }
                }
                request.setAttribute("filter", statusFilter);
                request.setAttribute("listE", filteredEvents);
                request.getRequestDispatcher("dashboard_admin/AdminEventManager.jsp").forward(request, response);
            } else if (action.equals("detail")) {
                int eventid = Integer.parseInt(request.getParameter("eventId"));
                Events event = new Events();
                event = dao.getDetailsEvents2(eventid);
                request.setAttribute("event", event);
                request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
            } else if (action.equals("approve")) {
                try {
                    int eventId = Integer.parseInt(request.getParameter("eventId"));
                    boolean approved = dao.approveEvent(eventId);
                    list = dao.getEvents(user.getUserId());
                    updateEventStatus(list);
                    request.setAttribute("listE", list);
                    request.setAttribute("message", approved ? "Duyệt sự kiện thành công!" : "Không thể duyệt sự kiện.");
                    request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("message", "Lỗi khi duyệt sự kiện.");
                    request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                }
            } else if (action.equals("reject")) {
                try {
                    int eventId = Integer.parseInt(request.getParameter("eventId"));
                    String rejectReason = request.getParameter("rejectReason");
                    if (rejectReason == null || rejectReason.trim().isEmpty()) {
                        request.setAttribute("message", "Vui lòng cung cấp lý do từ chối.");
                        request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                        return;
                    }
                    boolean rejected = dao.rejectEvent(eventId, rejectReason);
                    list = dao.getEvents(user.getUserId());
                    updateEventStatus(list);
                    request.setAttribute("listE", list);
                    request.setAttribute("message", rejected ? "Từ chối sự kiện thành công!" : "Không thể từ chối sự kiện.");
                    request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("message", "Lỗi khi từ chối sự kiện.");
                    request.getRequestDispatcher("dashboard_admin/AdminEventDetail.jsp").forward(request, response);
                }
            }

        }

    }

    private void updateEventStatus(ArrayList<Events> events) {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        for (Events e : events) {
            if (now.before(e.getStartTime())) {
                e.setEventStatus("Sắp diễn ra");
            } else if (now.after(e.getEndTime())) {
                e.setEventStatus("Đã kết thúc");
            } else {
                e.setEventStatus("Đang diễn ra");
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
        
            () {
        return "Short description";
        }// </editor-fold>

    }
