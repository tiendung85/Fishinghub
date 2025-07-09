/*
 * Click nb://SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nb://SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FishSpeciesDAO;
import model.FishSpecies;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Viehai
 */
@WebServlet(name = "FishManageServlet", urlPatterns = { "/FishManage" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 20 * 1024 * 1024)
public class FishManageServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(FishManageServlet.class.getName());
    private static final String UPLOAD_DIR = "C:\\Users\\pc\\Desktop\\Dung\\Dung\\Dung\\Dung\\Fishinghub\\web\\assets\\img\\FishKnowledge-images";

    // Phương thức hỗ trợ để chuẩn bị dữ liệu phân trang, tìm kiếm, lọc độ khó
    private void preparePagination(HttpServletRequest request, FishSpeciesDAO dao, int pageSize) throws Exception {
        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        String search = request.getParameter("search");
        String difficultyStr = request.getParameter("difficulty");
        Integer difficulty = (difficultyStr != null && !difficultyStr.isEmpty()) ? Integer.parseInt(difficultyStr)
                : null;
        List<FishSpecies> fishList = dao.getFishSpeciesByPageAndFilter(page, pageSize, search, difficulty);
        int totalFish = dao.getTotalFishSpeciesByFilter(search, difficulty);
        int totalPages = (int) Math.ceil((double) totalFish / pageSize);
        int endItem = Math.min(page * pageSize, totalFish);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalFish", totalFish);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("fishList", fishList);
        request.setAttribute("endItem", endItem);
        request.setAttribute("search", search);
        request.setAttribute("difficulty", difficultyStr);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageSize = 8;
        FishSpeciesDAO dao = new FishSpeciesDAO();
        try {
            preparePagination(request, dao, pageSize);
            request.getRequestDispatcher("/dashboard_admin/FishManage.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading fish list", e);
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h2>Lỗi khi tải danh sách loài cá</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        FishSpeciesDAO dao = new FishSpeciesDAO();
        int pageSize = 8;
        try {
            switch (action == null ? "" : action) {
                case "add": {
                    FishSpecies fish = new FishSpecies();
                    fish.setCommonName(request.getParameter("commonName"));
                    fish.setScientificName(request.getParameter("scientificName"));
                    fish.setDescription(request.getParameter("description"));
                    fish.setBait(request.getParameter("bait"));
                    fish.setBestSeason(request.getParameter("bestSeason"));
                    fish.setBestTimeOfDay(request.getParameter("bestTimeOfDay"));
                    fish.setFishingSpots(request.getParameter("fishingSpots"));
                    fish.setFishingTechniques(request.getParameter("fishingTechniques"));
                    fish.setDifficultyLevel(Integer.parseInt(request.getParameter("difficultyLevel")));
                    fish.setAverageWeightKg(request.getParameter("averageWeightKg") != null
                            && !request.getParameter("averageWeightKg").isEmpty()
                                    ? Double.parseDouble(request.getParameter("averageWeightKg"))
                                    : 0.0);
                    fish.setLength(request.getParameter("averageLengthCm") != null
                            && !request.getParameter("averageLengthCm").isEmpty()
                                    ? Double.parseDouble(request.getParameter("averageLengthCm"))
                                    : 0.0);
                    fish.setHabitat(request.getParameter("habitat"));
                    fish.setBehavior(request.getParameter("behavior"));
                    fish.setTips(request.getParameter("tips"));

                    // Thêm loài cá vào cơ sở dữ liệu trước để lấy fishId
                    dao.addFishSpecies(fish);
                    int fishId = fish.getId();

                    List<String> imageUrls = new ArrayList<>();
                    for (int i = 1; i <= 3; i++) {
                        Part filePart = request.getPart("image" + i);
                        if (filePart != null && filePart.getSize() > 0) {
                            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();//
                            String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
                            File uploadDir = new File(UPLOAD_DIR);
                            if (!uploadDir.exists()) {
                                uploadDir.mkdirs();
                            }
                            String filePath = UPLOAD_DIR + File.separator + fishId + "_" + i + fileExtension;
                            filePart.write(filePath);
                            String imageUrl = "assets/img/FishKnowledge-images/" + fishId + "_" + i + fileExtension;
                            imageUrls.add(imageUrl);
                            if (i == 1) {
                                fish.setImageUrl(imageUrl);
                            }
                        }
                    }
                    if (!imageUrls.isEmpty()) {
                        dao.insertImagesForFish(fishId, imageUrls, 0); // Ảnh đầu tiên là ảnh chính
                    }
                    request.getSession().setAttribute("message", "Đã thêm loài cá thành công!");
                    response.sendRedirect("FishManage");
                    return;
                }
                case "edit": {
                    String idStr = request.getParameter("id");
                    String commonName = request.getParameter("commonName");//
                    if (commonName == null && idStr != null) {
                        // Hiển thị form chỉnh sửa
                        try {
                            int id = Integer.parseInt(idStr);
                            FishSpecies fish = dao.getFishById(id);
                            if (fish == null) {
                                preparePagination(request, dao, pageSize);
                                request.setAttribute("message", "Loài cá không tồn tại!");
                                request.getRequestDispatcher("/dashboard_admin/FishManage.jsp").forward(request,
                                        response);
                                return;
                            }
                            if (fish.getImages() == null) {
                                fish.setImages(new ArrayList<>());
                            }
                            preparePagination(request, dao, pageSize);
                            request.setAttribute("editFish", fish);
                            request.getRequestDispatcher("/dashboard_admin/FishManage.jsp").forward(request, response);
                        } catch (NumberFormatException e) {
                            preparePagination(request, dao, pageSize);
                            request.setAttribute("message", "ID loài cá không hợp lệ!");
                            request.getRequestDispatcher("/dashboard_admin/FishManage.jsp").forward(request, response);
                        }
                        return;
                    } else {
                        // Lưu thông tin cập nhật
                        int id = Integer.parseInt(idStr);
                        FishSpecies fish = new FishSpecies();
                        fish.setId(id);
                        fish.setCommonName(commonName);
                        fish.setScientificName(request.getParameter("scientificName"));
                        fish.setDescription(request.getParameter("description"));
                        fish.setBait(request.getParameter("bait"));
                        fish.setBestSeason(request.getParameter("bestSeason"));
                        fish.setBestTimeOfDay(request.getParameter("bestTimeOfDay"));
                        fish.setFishingSpots(request.getParameter("fishingSpots"));
                        fish.setFishingTechniques(request.getParameter("fishingTechniques"));
                        fish.setDifficultyLevel(Integer.parseInt(request.getParameter("difficultyLevel")));
                        String avgWeight = request.getParameter("averageWeightKg");
                        fish.setAverageWeightKg(
                                avgWeight != null && !avgWeight.isEmpty() ? Double.parseDouble(avgWeight) : 0.0);
                        String avgLength = request.getParameter("averageLengthCm");
                        fish.setLength(avgLength != null && !avgLength.isEmpty() ? Double.parseDouble(avgLength) : 0.0);
                        fish.setHabitat(request.getParameter("habitat"));
                        fish.setBehavior(request.getParameter("behavior"));
                        fish.setTips(request.getParameter("tips"));

                        // Lấy danh sách ảnh hiện có
                        List<String> existingImages = dao.getImagesByFishSpeciesId(id);
                        List<String> newImageUrls = new ArrayList<>();
                        for (int i = 1; i <= 3; i++) {
                            Part filePart = request.getPart("image" + i);
                            if (filePart != null && filePart.getSize() > 0) {
                                // Có ảnh mới, lưu ảnh
                                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                                String fileExtension = fileName.substring(fileName.lastIndexOf('.'));
                                File uploadDir = new File(UPLOAD_DIR);
                                if (!uploadDir.exists()) {
                                    uploadDir.mkdirs();
                                }
                                String filePath = UPLOAD_DIR + File.separator + id + "_" + i + fileExtension;
                                filePart.write(filePath);
                                String imageUrl = "assets/img/FishKnowledge-images/" + id + "_" + i + fileExtension;
                                newImageUrls.add(imageUrl);
                                // Cập nhật ảnh riêng lẻ
                                String oldImageUrl = (i <= existingImages.size()) ? existingImages.get(i - 1) : null;
                                dao.updateSingleImage(id, oldImageUrl, imageUrl, i == 1);
                                if (i == 1) {
                                    fish.setImageUrl(imageUrl);
                                }
                            } else {
                                // Giữ ảnh cũ nếu không có ảnh mới
                                if (i <= existingImages.size()) {
                                    newImageUrls.add(existingImages.get(i - 1));
                                }
                            }
                        }
                        dao.updateFishSpecies(fish);
                        if (!newImageUrls.isEmpty()) {
                            dao.updateImagesForFish(id, newImageUrls, 0); // Ảnh đầu tiên là ảnh chính
                        }
                        request.getSession().setAttribute("message", "Đã cập nhật loài cá thành công!");
                        response.sendRedirect("FishManage");
                        return;
                    }
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    dao.deleteFishSpecies(id);
                    request.getSession().setAttribute("message", "Đã xóa loài cá thành công!");
                    response.sendRedirect("FishManage");
                    return;
                }
                default:
                    break;
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing CRUD operation: " + action, e);
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h2>Lỗi xử lý CRUD FishManageServlet</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
            }
            return;
        }
        response.sendRedirect("FishManage");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}