/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.FishingLakeDAO;
import dal.FishSpeciesDAO;
import jakarta.servlet.http.HttpSession;
import model.Users;
import model.FishingLake;
import model.FishSpecies;
import model.LakeFishInfo;

/**
 *
 * @author Viehai
 */
@WebServlet(name = "LakeServlet", urlPatterns = { "/LakeServlet" })
public class LakeServlet extends HttpServlet {

    private final FishingLakeDAO fishingLakeDAO = new FishingLakeDAO();
    private final FishSpeciesDAO fishSpeciesDAO = new FishSpeciesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("user");

        // Kiểm tra người dùng và vai trò
        if (currentUser == null || currentUser.getRoleId() != 2) {
            response.sendRedirect("Home.jsp");
            return;
        }

        // Lấy danh sách hồ câu từ DAO
        List<FishingLake> lakes = null;
        List<FishSpecies> fishSpeciesList = null;
        try {
            lakes = fishingLakeDAO.getLakesByOwnerId(currentUser.getUserId());
            if (lakes != null) {
                for (FishingLake lake : lakes) {
                    List<String> fishNames = fishingLakeDAO.getFishSpeciesNamesByLakeId(lake.getLakeId());
                    lake.setFishSpeciesNames(fishNames);
                    // Lấy danh sách loài cá chưa có trong hồ này và set vào object hồ
                    List<FishSpecies> notInLake = fishingLakeDAO.getFishSpeciesNotInLake(lake.getLakeId());
                    lake.setFishSpeciesNotInLake(notInLake);
                    // Lấy danh sách cá và giá tiền trong hồ này
                    List<LakeFishInfo> fishInfoList = fishingLakeDAO.getLakeFishInfoList(lake.getLakeId());
                    lake.setLakeFishInfoList(fishInfoList);
                }
            }
            fishSpeciesList = fishSpeciesDAO.getAllFishSpecies();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách hồ câu. Vui lòng thử lại sau.");
        }

        // Truyền dữ liệu sang JSP
        request.setAttribute("lakes", lakes);
        request.setAttribute("fishSpeciesList", fishSpeciesList);
        request.getRequestDispatcher("Lake.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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