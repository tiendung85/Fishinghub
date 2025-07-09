
package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.List;
import model.Category;
import model.Product;

@WebServlet(name = "ProductManageServlet", urlPatterns = { "/ProductManage" })
public class ProductManageServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "E:\\Fishinghub\\FishingHub\\web\\assets\\img\\Product-images";

    private void preparePagination(HttpServletRequest request, ProductDAO dao, CategoryDAO cateDao, int pageSize)
            throws Exception {
        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        List<Product> fishList = dao.getProductsByPage(page, pageSize);
        int totalFish = dao.getTotalProductCount();
        int totalPages = (int) Math.ceil((double) totalFish / pageSize);
        int endItem = Math.min(page * pageSize, totalFish);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalFish", totalFish);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("fishList", fishList);
        request.setAttribute("endItem", endItem);

        List<Category> cateList = cateDao.getAllCategory();
        request.setAttribute("cateList", cateList);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageSize = 8;
        ProductDAO dao = new ProductDAO();
        CategoryDAO cateDao = new CategoryDAO();
        try {
            preparePagination(request, dao, cateDao, pageSize);
            request.getRequestDispatcher("/dashboard_owner/ProductManage.jsp").forward(request, response);
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h2>Lỗi khi tải danh sách sản phẩm</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        CategoryDAO cateDao = new CategoryDAO();
        System.out.println("action: " + action);
        int pageSize = 8;

        try {
            switch (action == null ? "" : action) {
                case "add": {
                    Product fish = new Product();
                    fish.setCategoryId(Integer.parseInt(request.getParameter("difficultyLevel")));
                    fish.setName(request.getParameter("commonName"));
                    fish.setPrice(Double.parseDouble(request.getParameter("scientificName")));
                    fish.setStockQuantity(Integer.parseInt(request.getParameter("bestSeason")));

                    boolean rs = dao.addProduct(fish);

                    if (rs) {
                        request.getSession().setAttribute("message", "Đã thêm sản phẩm thành công!");
                        response.sendRedirect("ProductManage");
                        return;
                    } else {
                        throw new Exception("Insert FAIL");
                    }
                }
                case "edit": {
                    String idStr = request.getParameter("id");
                    String newData = request.getParameter("newData");
                    if (idStr != null && newData == null) {

                        try {
                            int id = Integer.parseInt(idStr);
                            Product fish = dao.getProductById(id);
                            if (fish == null) {

                                return;
                            }

                            preparePagination(request, dao, cateDao, pageSize);
                            request.setAttribute("editFish", fish);
                            request.getRequestDispatcher("/dashboard_owner/ProductManage.jsp").forward(request,
                                    response);
                        } catch (NumberFormatException e) {
                            preparePagination(request, dao, cateDao, pageSize);
                            request.setAttribute("message", "ID sản phẩm không hợp lệ!");
                            request.getRequestDispatcher("/dashboard_owner/ProductManage.jsp").forward(request,
                                    response);
                        }
                        return;
                    } else {

                        System.out.println("EDITING....");
                        int id = Integer.parseInt(idStr);
                        Product fish = new Product();
                        fish.setProductId(id);
                        fish.setCategoryId(Integer.parseInt(request.getParameter("difficultyLevel")));
                        fish.setName(request.getParameter("commonName"));
                        fish.setPrice(Double.parseDouble(request.getParameter("scientificName")));
                        fish.setStockQuantity(Integer.parseInt(request.getParameter("bestSeason")));
                        fish.setSoldQuantity(Integer.parseInt(request.getParameter("sold")));

                        boolean rs = dao.updateProduct(fish);
                        if (rs) {
                            request.getSession().setAttribute("message", "Đã cập nhật sản phẩm thành công!");
                            response.sendRedirect("ProductManage");
                            return;
                        } else {
                            throw new Exception("Update FAIL");
                        }
                    }
                }
                case "delete": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean rs = dao.deleteProduct(id);
                    if (rs) {
                        request.getSession().setAttribute("message", "Đã xóa sản phẩm thành công!");
                        response.sendRedirect("ProductManage");
                        return;
                    } else {
                        throw new Exception("DELETE FAIL!");
                    }
                }
                default:
                    break;
            }
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h2>Lỗi xử lý CRUD ProductManageServlet</h2>");
                out.println("<pre>" + e.getMessage() + "</pre>");
            }
            return;
        }
        response.sendRedirect("ProductManage");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}