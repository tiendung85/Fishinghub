package controller;

import dal.FishSpeciesDAO;
import model.FishSpecies;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "FishDetailsServlet", urlPatterns = {"/FishDetails"})
public class FishDetailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("FishKnowledge");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("FishKnowledge");
            return;
        }
        FishSpeciesDAO dao = new FishSpeciesDAO();
        FishSpecies fish = dao.getFishById(id);
        if (fish == null) {
            response.sendRedirect("FishKnowledge");
            return;
        }
        request.setAttribute("fish", fish);
        request.getRequestDispatcher("FishDetails.jsp").forward(request, response);
    }
}
