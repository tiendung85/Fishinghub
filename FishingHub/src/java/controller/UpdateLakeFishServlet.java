package controller;

import dal.FishingLakeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UpdateLakeFishServlet", urlPatterns = { "/updateLakeFish" })
public class UpdateLakeFishServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lakeIdStr = request.getParameter("lakeId");
        String[] fishIds = request.getParameterValues("fishSpeciesIds");
        if (lakeIdStr == null) {
            response.sendRedirect("LakeServlet?error=missing_data");
            return;
        }
        int lakeId = Integer.parseInt(lakeIdStr);
        List<Integer> fishSpeciesIds = new ArrayList<>();
        List<Double> prices = new ArrayList<>();
        FishingLakeDAO lakeDAO = new FishingLakeDAO();
        if (fishIds != null) {
            for (String fishIdStr : fishIds) {
                int fishId = Integer.parseInt(fishIdStr);
                String priceStr = request.getParameter("fishPrices_" + fishId);
                double price;
                if (priceStr != null && !priceStr.trim().isEmpty()) {
                    price = Double.parseDouble(priceStr);
                } else {
                    try {
                        Double oldPrice = lakeDAO.getPrice(lakeId, fishId);
                        price = (oldPrice != null) ? oldPrice : 0;
                    } catch (Exception e) {
                        price = 0;
                    }
                }
                fishSpeciesIds.add(fishId);
                prices.add(price);
            }
        }
        try {
            lakeDAO.removeAllFishFromLake(lakeId);
            if (!fishSpeciesIds.isEmpty()) {
                lakeDAO.addFishToLake(lakeId, fishSpeciesIds, prices);
            }
            response.sendRedirect("LakeServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("LakeServlet");
        }
    }
}