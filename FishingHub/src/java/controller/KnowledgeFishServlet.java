package controller;

import dal.FishSpeciesDAO;
import model.FishSpecies;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "KnowledgeFishServlet", urlPatterns = {"/KnowledgeFish"})
public class KnowledgeFishServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 8;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        FishSpeciesDAO dao = new FishSpeciesDAO();
        try {
            List<FishSpecies> fishList = dao.getFishSpeciesByPage(page, pageSize);
            int totalFish = dao.getTotalFishSpecies();
            int totalPages = (int) Math.ceil((double) totalFish / pageSize);

            request.setAttribute("fishList", fishList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("KnowledgeFish.jsp").forward(request, response);
    }
}
