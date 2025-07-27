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
import model.LakeCustomFish;

@WebServlet(name = "UpdateLakeFishServlet", urlPatterns = {"/updateLakeFish"})
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

        // Cá hệ thống
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

        // --- THÊM ĐOẠN NÀY: Xử lý cá custom ---
        String[] customFishNames = request.getParameterValues("customFishName");
        String[] customFishPrices = request.getParameterValues("customFishPrice");

        // Xoá tất cả custom fish cũ của hồ này để thêm mới (nếu muốn cập nhật toàn bộ)
        lakeDAO.removeAllCustomFishFromLake(lakeId);

        if (customFishNames != null && customFishPrices != null) {
            for (int i = 0; i < customFishNames.length; i++) {
                String name = customFishNames[i];
                String priceStr = customFishPrices[i];
                if (name != null && !name.trim().isEmpty()) {
                    double price = 0;
                    if (priceStr != null && !priceStr.trim().isEmpty()) {
                        price = Double.parseDouble(priceStr);
                    }
                    LakeCustomFish customFish = new LakeCustomFish();
                    customFish.setLakeId(lakeId);
                    customFish.setFishName(name.trim());
                    customFish.setPrice(price);
                    lakeDAO.addCustomFish(customFish);
                }

            }
        }
        // --- KẾT THÚC ĐOẠN THÊM ---

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