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
        String difficulty = request.getParameter("difficulty");

        FishSpeciesDAO dao = new FishSpeciesDAO();
        try {
            List<FishSpecies> fishList;
            int totalPages = 1;
            if (difficulty != null) {
                // Lọc theo độ khó, không phân trang
                if (difficulty.equals("hard")) {
                    fishList = dao.getFishByDifficulty(3, 4);
                } else if (difficulty.equals("easy")) {
                    fishList = dao.getFishByDifficulty(1, 2);
                } else {
                    fishList = dao.getAllFishSpecies();
                }
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);
            } else {
                // Phân trang như cũ
                if (request.getParameter("page") != null) {
                    try {
                        page = Integer.parseInt(request.getParameter("page"));
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                }
                fishList = dao.getFishSpeciesByPage(page, pageSize);
                int totalFish = dao.getTotalFishSpecies();
                totalPages = (int) Math.ceil((double) totalFish / pageSize);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
            }
            request.setAttribute("fishList", fishList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("KnowledgeFish.jsp").forward(request, response);
    }
}